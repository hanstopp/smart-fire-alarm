--Modulo HTTP
function httpPost(url, datos)
	data = sjson.encode(datos)
	http.post(url, 
		"Content-type": "application/x-www-form-urlencoded", "Accept": "application/json", 
		data,
		function (code, data)
			if code < 0 then
				print("La Peticion Fallo!")
			else
				print(code, sjson.decode(data))
			end
		end)
end