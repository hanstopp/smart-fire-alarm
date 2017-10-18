---------- imports ----------
local mcu_action = require('mcu_action')
local srv_action = require('srv_action')
-----------------------------

---------- clean ----------
wifi.ap.dhcp.stop()
collectgarbage()
---------------------------

---------- adc init config ----------
if adc.force_init_mode(adc.INIT_ADC) then 
    node.restart()
end
-------------------------------------

---------- wifi and net init config ----------
wifi.setmode(wifi.STATIONAP)
math.randomseed(tmr.time())
wifi.ap.config({ssid = "MCU_"..math.random(0,9)..math.random(0,9)..math.random(0,9)..""})
wifi.ap.setip({ip = "192.168.1.1", netmask = "255.255.255.0", gateway = "192.168.1.1"})
wifi.ap.dhcp.config({start = "192.168.1.100"})
net.dns.setdnsserver("8.8.8.8", 0)
net.dns.setdnsserver("8.8.4.4", 1)
wifi.ap.dhcp.start()

if file.exists("credential.json") then
    if file.open("credential.json") then
        wifi.sta.config(cjson.decode(file.read()))
        wifi.sta.connect()
        file.close()
    end
end
----------------------------------------------

---------- Server listener ----------
srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(client,request)

        ---------- get post args ----------
        local args = string.match(request,"\r\n\r\n(.*)")
        if args == "" then args="{}" end
        print(args)
        args = cjson.decode(args)
        -----------------------------------

        ---------- mcu_action receive ----------
        if args.mcu_action ~= nil then
            if args.mcu_action == "set_credential" then
                mcu_action.set_credential(client,args)
            elseif args.mcu_action == "get_adc" then
                mcu_action.get_adc(client)
            elseif args.mcu_action == "get_ip" then
                mcu_action.get_ip(client)
            elseif args.mcu_action == "get_networks" then
                mcu_action.get_networks(client)
            else
                client:send('{"ERROR":"NilReturn","Message":"The action is not recognized"}')
            end
        ----------------------------------------

        ---------- srv_action receive ----------
        elseif args.srv_action ~= nil then
            if wifi.sta.getip() ~= nil then
                if args.srv_action == "set_user" then
                    client:send(srv_action.set_user(args))
                else
                    client:send('{"ERROR":"NilReturn","Message":"The action is not recognized"}')
                end
            else
                client:send('{"ERROR":"NilReturn","Message":"NodeMCU is not Connected"}')
            end
        ----------------------------------------

        ---------- on invalid post ----------
        else
            client:send('{"ERROR":"NilReturn","Message":"None is returned"}')
        end
        -------------------------------------
    end)
    conn:on("sent",function(client)
        client:close() 
    end)
end)
-------------------------------------
