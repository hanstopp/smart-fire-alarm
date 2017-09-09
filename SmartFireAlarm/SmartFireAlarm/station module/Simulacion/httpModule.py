# -*- coding: utf-8 -*-
import httplib
class Http():
    def __init__(self, host):
        self.cnx = httplib.HTTPConnection(host)

    def post(self, url, headers, body, callback):
        self.cnx.request('POST', url, body, headers)
        callback(self.cnx)
        respuesta = self.cnx.getresponse()
        if respuesta.status == 200:
            return respuesta.read()
        else:
            return -1

    def Close(self):
        return self.cnx.close()