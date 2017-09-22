dofile("credential.lua");

WifiConnected = function(T)
    print("Conexion a ("..T.SSID..") establecida!")
    print("Esperando la direccion IP...")
    if dCount ~= nil then dCount = nil end
end

WifiIpObtenida = function(T)
    print("La direccion ip recibida es: "..T.IP)
end

Desconexion = function(T)
    if T.reason == wifi.eventmon.reason.ASSOC_LEAVE then
        return
    end
    local intentos = 50
    print("Conexion a ("..T.SSID..") ha fallado!")
    for Codigo ,Razon in pairs(wifi.eventmon.reason) do
        if Codigo == T.reason then
          print("La Razon de la desconexion es: "..Razon.."("..Codigo..")")
          break
        end
    end
    if dCount == nil then 
        dCount = 1 
    else
        dCount = dCount + 1 
    end
    if dCount < intentos then 
        print("Intentando Reconectar...(Intento "..(dCount+1).." de "..intentos..")")
    else
        wifi.sta.disconnect()
        print("Abortando conexion!")
        dCount = nil  
    end
end

wifi.eventmon.register(wifi.eventmon.STA_CONNECTED, WifiConnected)
wifi.eventmon.register(wifi.eventmon.STA_GOT_IP, WifiIpObtenida)
wifi.eventmon.register(wifi.eventmon.STA_DISCONNECTED, Desconexion)
print("Conectando a la red Wifi..")
wifi.setmode(wifi.STATION)
-- SSID y PASSWORD se pueden incluir desde otro archivo .lua al comienzo del init con dofile("FileName.lua")
wifi.sta.config({ssid=SSID, pwd=PASSWORD})
tmr.alarm(0, 1000, 1, function()
   if wifi.sta.getip() == nil then
       print("Conectando...\n")
   else
       tmr.stop(0) -- cuando se obtenga ip se activa la funcion ipobtenida que imprime la IP.
   end
end)


-- Seccion de monitoreo
mSeg = 3000
-- Cambia el modo de operacion del adc, si se cambio de modo devuelve true, entonces se debe reiniciar el node
-- si no se cambio significa que ya estaba en el modo de operacion que queremos.
if adc.force_init_mode(adc.INIT_ADC) then 
    node.restart()
    return
end
Count = 0
tmr.alarm(0, mSeg, 1, function ()
    Value = adc.read(0)
    Count = Count + 1
    print("El Valor Leido es (mV):"..Value)
    if Count == 10 then
        tmr.stop(0)
    end
end)
--dofile("httpModule.lua") -- (en proceso)
--Datos = {["x"] = adc.read(0)}
--local encode = sjson.encode(Datos)
--print("Json: "..encode)
--httpPost("http://localhost:8090/Test-httplib/index.php",Datos)