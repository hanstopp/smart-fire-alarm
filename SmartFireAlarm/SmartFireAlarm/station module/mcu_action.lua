local mcu_action = {}

local function set_credential(dict)
    file.remove("credential.json")
    if file.open("credential.json") then
        local str = '{"ssid":"'..dict.ssid..'"'
        if dict.pwd ~= nil then
            str = str..',"pwd":"'..dict.pwd..'"'
        end
        str = str..'}'
        file.writeline(str)
        file.close()
        wifi.sta.disconnect()
        wifi.sta.config(sjson.decode(str))
        wifi.sta.connect()
        return '{"Message":"success"}'
    else
        return '{"ERROR":"NilFile","Message":"Error has occurred while trying to manipulate the file"}'
    end
end

local function get_adc()
    return '{"Value":'..adc.read(0)..',"Message":"Success"}'
end

local function get_ip()
    if wifi.sta.getip() ~= nil then
        return '{"Value":"'..wifi.sta.getip()..'","Message":Success}'
    else
        return '{"ERROR":"NilReturn","Message":"NodeMCU is not Connected"}'
    end
end

mcu_action.set_credential = set_credential
mcu_action.get_adc = get_adc
mcu_action.get_ip = get_ip

return mcu_action