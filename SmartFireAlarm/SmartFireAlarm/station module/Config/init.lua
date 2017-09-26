if adc.force_init_mode(adc.INIT_ADC) then 
    node.restart()
end

wifi.setmode(wifi.STATIONAP)
wifi.ap.config({ssid = "MCU_001"})
wifi.ap.setip({ip = "192.168.1.1", netmask = "255.255.255.0", gateway = "192.168.1.1"})
net.dns.setdnsserver("8.8.8.8", 0)
net.dns.setdnsserver("8.8.4.4", 1)
cfg = {ssid = ""}
if file.exists("credential.json") then
    if file.open("credential.json") then
        cfg = sjson.decode(file.read())
        file.close()
    end
end
wifi.sta.config(cfg)
wifi.sta.connect()

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(client,request)
        local args = string.match(request,"\r\n\r\n(.*)")
        if args == "" then args="{}" end
        print(args)
        args = sjson.decode(args)
        if args.mcu_action ~= nil then
            if args.mcu_action == "print_test" then
                print(args.content)
                client:send("{\"Message\":\"Success\"}")
            elseif args.mcu_action == "set_credential" then
                file.remove("credential.json")
                if file.open("credential.json", "w+") then
                    str = "{\"ssid\":\""..args.ssid.."\""
                    if args.pwd ~= nil then
                        str = str..",\"pwd\":\""..args.pwd.."\""
                    end
                    str = str.."}"
                    file.writeline(str)
                    file.close()
                    wifi.sta.disconnect()
                    wifi.sta.config(sjson.decode(str))
                    wifi.sta.connect()
                    client:send("{\"Message\":\"Success\"}")
                else
                    client:send("{\"ERROR\":\"NilFile\",\"Message\":\"Error has occurred while trying to manipulate the file\"}")
                end
            elseif args.mcu_action == "restart" then
                client:send("{\"Message\":\"Success\"}")
            elseif args.mcu_action == "get_adc" then
                client:send("{\"Value\":"..adc.read(0)..",\"Message\":\"Success\"}")
            elseif args.mcu_action == "get_ip" then
                if wifi.sta.getip() ~= nil then
                    client:send("{\"Value\":\""..wifi.sta.getip().."\",\"Message\":\"Success\"}")
                else
                    client:send('{"ERROR":"NilReturn","Message":"NodeMCU is not Connected"}')
                end
            else
                client:send("{\"ERROR\":\"NilReturn\",\"Message\":\"The action is not recognized\"}")
            end
        elseif args.srv_action ~= nil then
            if wifi.sta.getip() ~= nil then
                if args.srv_action == "set_user" then
                    http.post("http://pillan.inf.uct.cl/~aflores/test.php",
                        "Content-Type: application/x-www-form-urlencoded\r\nAccept: application/json\r\n",
                        sjson.encode(args), function (code, data)
                            if code < 0 then
                                client:send("{\"ERROR\":\"PostError\",\"Message\":\"No se pudo realizar el post\"}")
                            else
                                if sjson.decode(data).Error == nil then
                                    file.remove("user.json")
                                    if file.open("user.json","w+") then
                                        file.writeline(data)
                                        file.close()
                                    end
                                    client:send(data)
                                else
                                    client:send(data)
                                end
                            end
                        end)
                else
                    client:send("{\"ERROR\":\"NilReturn\",\"Message\":\"The action is not recognized\"}")
                end
            else
                client:send("{\"ERROR\":\"NilReturn\",\"Message\":\"NodeMCU is not Connected\"}")
            end
        else
            client:send("{\"ERROR\":\"NilReturn\",\"Message\":\"None is returned\"}")
        end
    end)
    conn:on("sent",function(client)
        client:close() 
    end)
end)