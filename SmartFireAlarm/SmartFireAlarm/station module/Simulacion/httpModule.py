# -*- coding: utf-8 -*-
import httplib, json, urllib
class Http():
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.name = "x"

    def post(self, url, body):
        try: cnx = httplib.HTTPConnection(self.host+":"+self.port)
        except: return -1
        header = {"Content-type": "application/x-www-form-urlencoded", "Accept": "application/json"}
        cnx.request('POST', url, urllib.urlencode({self.name:json.dumps(body)}), header)
        response = cnx.getresponse()
        if response.status == 200:
            try: result = json.loads(response.read())
            except: result = -1
        else:
            result = -1
        cnx.close()
        return result