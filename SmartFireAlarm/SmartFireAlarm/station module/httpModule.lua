local httpModule = {}

local function httpPost(url,dict)
    local request = '{"ERROR":"CallbackError"}'
    http.post(url,
        "Content-Type: application/x-www-form-urlencoded\r\nAccept: application/json\r\n",
        sjson.encode(dict),
        function (code,data)
            if code < 0 then
                request = '{"ERROR":"PostError","Message":"No se pudo realizar el post"}'
            else
                request = data
            end
        end)
    return request
end

httpModule.httpPost = httpPost

return httpModule
