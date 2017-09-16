local str=wifi.ap.getmac();
local ssidTemp=string.format("%s%s%s",string.sub(str,10,11),string.sub(str,13,14),string.sub(str,16,17));

cfg={}
cfg.ssid="MCU"..ssidTemp
cfg.pwd="jpk.5332";
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
        print(request)
        client:send("{\"campo1\":\"valor1\"}")
    end)
    
    conn:on("sent",function(client)
    	client:close() 
    end)
end)
