local mcu_action = {}

local function get_networks(client)
    if wifi.getmode() == wifi.STATIONAP then
        local list = '{}'
        wifi.sta.getap(function(T)
            list = '{'
            local i = 0
            for k,v in pairs(T) do
                list = list..'"'..i..'"'..':'..'"'..k..'",'
                i = i + 1
            end
            list = string.sub(list,1,-2)..'}'
            if list ~= nil then
                client:send(list)
            else
                client:send('{"ERROR":"NilReturn", "Message":"None is return"}')
            end
        end)
    else
        client:send('{"ERROR":"NilReturn","Message":"WifiStationAP not established"}')
    end
end

local function set_credential(client,dict)
    file.remove("credential.json")
    if file.open("credential.json", "w+") then
        local str = '{"ssid":"'..dict.ssid..'"'
        if dict.pwd ~= nil then
            str = str..',"pwd":"'..dict.pwd..'"'
        end
        str = str..'}'
        file.writeline(str)
        file.close()
        wifi.sta.disconnect()
        wifi.sta.config(cjson.decode(str))
        wifi.sta.connect()
        client:send('{"Message":"success"}')
    else
        client:send('{"ERROR":"nilFile","Message":"Error has occurred while trying to manipulate the file"}')
    end
end

local function get_adc(client)
    client:send('{"Value":'..adc.read(0)..',"Message":"Success"}')
end

local function get_ip(client)
    if wifi.sta.getip() ~= nil then
        client:send('{"Value":"'..wifi.sta.getip()..'","Message":"Success"}')
    else
        client:send('{"ERROR":"NilReturn","Message":"NodeMCU is not Connected"}')
    end
end

mcu_action.set_credential = set_credential
mcu_action.get_adc = get_adc
mcu_action.get_ip = get_ip
mcu_action.get_networks = get_networks

return mcu_action
