local httpModule = require('httpModule')

local srv_action = {}

local function set_user(client,dict)
    local request = httpModule.httpPost('http://pillan.inf.uct.cl/~aflores/test.php',dict)
    if cjson.decode(request).ERROR == nil then
        file.remove("user.json")
        if file.open("user.json","w+") then
            file.writeline(data)
            file.close()
            client:send('{"Message":"Success"}')
        else
            client:send('{"ERROR":"NilFile","Message":"Error has occurred while trying to manipulate the file"}')
        end
    else
       client:send(request)
    end
end

srv_action.set_user = set_user

return srv_action
