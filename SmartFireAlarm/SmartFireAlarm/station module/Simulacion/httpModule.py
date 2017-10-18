# -*- coding: utf-8 -*-
import httplib, json, urllib
class Http():
    def __init__(self, host, port):
        self.host = host
        self.port = port

    def post(self, url, body):
        try:
            cnx = httplib.HTTPConnection(self.host+":"+self.port)
        except Exception, e:
            return -1
        header = {"Content-type": "application/x-www-form-urlencoded", "Accept": "application/json"}
        try:
            cnx.request('POST', url, json.dumps(body), header)
            response = cnx.getresponse()
            if response.status == 200:
                data = response.read()
                try:
                    result = json.loads(data)
                except Exception, e:
                    result = -2
            else:
                result = -1
            cnx.close()
            return result
        except Exception, e:
            return -1
