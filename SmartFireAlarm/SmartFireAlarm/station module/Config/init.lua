local str=wifi.ap.getmac();
local ssidTemp=string.format("%s%s%s",string.sub(str,10,11),string.sub(str,13,14),string.sub(str,16,17));

cfg={}
cfg.ssid="MCU"..ssidTemp
cfg.pwd="12345678";
wifi.ap.config(cfg)

cfg={}
cfg.ip="192.168.1.1";
cfg.netmask="255.255.255.0";
cfg.gateway="192.168.1.1"
wifi.ap.setip(cfg);
wifi.setmode(wifi.SOFTAP)

str=nil
ssidTemp=nil
collectgarbage();

srv=net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(client,request)
        local vars = strig.match(request,"\r\n\r\n(.*)")
        if vars.volumen > 40 then
        	client:send("{\"campo1\":\"valor1\"}")
        else
        	client:send("{\"campo2\":\"valor2\"}")
        end
    end)
    
    conn:on("sent",function(client)
    	client:close() 
    end)
end)
