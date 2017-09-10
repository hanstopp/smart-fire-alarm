# -*- coding: utf-8 -*-
import httplib, json
class Http():
    def __init__(self, host):
        self.cnx = httplib.HTTPConnection(host)

    def post(self, url, body):
        self.header = {"Content-type": "application/x-www-form-urlencoded", "Accept": "application/json"}
        self.cnx.request('POST', url, body, self.header)
        respuesta = self.cnx.getresponse()
        if respuesta.status == 200:
            return json.loads(respuesta.read())
        else:
            return -1

    def Close(self):
        return self.cnx.close()