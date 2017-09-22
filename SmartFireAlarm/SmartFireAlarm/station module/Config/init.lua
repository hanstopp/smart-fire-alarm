if adc.force_init_mode(adc.INIT_ADC) then 
    node.restart()
    return
end

Connected = false

if file.exists("credential.lua") then
    dofile("credential.lua")
    print(SSID)
    print(PASSWORD)
    wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, WifiConnected)
    wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, WifiIpObtenida)
    wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, Desconexion)

    wifi.setmode(wifi.STATION)
    wifi.sta.config({ssid=SSID, pwd=PASSWORD})

    for i=1,10 do
        if wifi.sta.getip() == nil then
            print("Conectando...\n")
            tmr.delay(1000)
        else
            Connected = true
            break
        end
    end
end

if not Connected then
    local str=wifi.ap.getmac()
    local ssidTemp=string.format("%s%s%s",string.sub(str,10,11),string.sub(str,13,14),string.sub(str,16,17))

    cfg={}
    cfg.ssid="MCU"..ssidTemp
    cfg.pwd="12345678"
    wifi.ap.config(cfg)

    cfg={}
    cfg.ip="192.168.1.1"
    cfg.netmask="255.255.255.0"
    cfg.gateway="192.168.1.1"
    wifi.ap.setip(cfg)
    wifi.setmode(wifi.SOFTAP)

    str=nil
    ssidTemp=nil
    cfg=nil
    collectgarbage()

    srv=net.createServer(net.TCP)
    srv:listen(80,function(conn)
        conn:on("receive",function(client,request)
            local args = string.match(request,"\r\n\r\n(.*)")
            if args.mcu_action ~= nil then
                if args.mcu_action == "print_test" then
                    print(args.content)
                    client:send("{\"Message\":\"Success\"}")
                elseif args.mcu_action == "set_credential" then
                    file.remove("credential.lua")
                    if file.open("credential.lua", "w+") then
                        file.writeline("SSID="..args.ssid)
                        file.writeline("PASSWORD"..args.pwd)
                        file.close()
                        client:send("{\"Message\":\"Success\"}")
                    else
                        client:send("{\"ERROR\":\"NilFile\",\"Message\":\"Error has occurred while trying to manipulate the file\"}")
                    end
                elseif args.mcu_action == "restart" then
                    client:send("{\"Message\":\"Success\"}")
                    -- node.restart() or goto line1
                elseif args.mcu_action == "get_adc" then
                    client:send("{\"Value\":\""..adc.read(0).."\",\"Message\":\"Success\"}")
                else
                    client:send("{\"ERROR\":\"NilReturn\",\"Message\":\"The action is not recognized\"}")
                end
            else
                client:send("{\"ERROR\":\"NilReturn\",\"Message\":\"None is Returned\"}")
            end
        end)
        conn:on("sent",function(client)
            client:close() 
        end)
    end)
else
    -- cosas del modo estacion
end