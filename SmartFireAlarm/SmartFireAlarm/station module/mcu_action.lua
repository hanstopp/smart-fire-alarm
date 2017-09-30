local mcu_action = {}

local function getNerworks(T)
    if wifi.getmode() == wifi.STATIONAP then
        local list = '{'
        local newList = {}
        local i = 0
        for k,v in pairs(T) do
            table.insert(newList, k)
        end
        for i,k in ipairs(newList) do
            if i == table.maxn(newList) then
                list = list..'"'.. i-1 ..'" : "'..k..'"'
            else
                list = list..'"'.. i-1 ..'" : "'..k..'" ,'
            end
        end
        list = list..'}'
        mcu_action.nets = list
        print(list)
    else
        print("ERROR")
    end
end

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
        wifi.sta.config(cjson.decode(str))
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
mcu_action.netScan = getNetworks

return mcu_action