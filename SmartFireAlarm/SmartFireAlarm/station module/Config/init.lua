wifi.setmode(wifi.STATION)
wifi.sta.config("MCU001","mcu001")
srv = net.createServer(net.TCP)
srv:listen(80,function(conn)
    conn:on("receive",function(client,request)
        
        local buff = "";
        buff = buff.."<h1>Configuración</h1>";
        buff = buff.."<form>";
        buff = buff.."<table>"; -- aqui iria la lista de redes. necesito saber como hacer scan
        buff = buff.."<tr><td><input type=\"radio\" name=\"red\" value=\"RED1\"></td><td>RED1</td></tr>";
        buff = buff.."<tr><td><input type=\"radio\" name=\"red\" value=\"RED1\"></td><td>RED2</td></tr>";
        buff = buff.."</table>";
        buff = buff.."<input type=\"password\" name=\"pass\">";
        buff = buff.."</form>";

        client:send(buf);
        client:close();
        collectgarbage();
    end)
end
