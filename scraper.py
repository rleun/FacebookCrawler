
import urllib2
import json
import datetime
import csv
import time

#Access token
app_id = "372396713160018"
app_secret = "0a79efd41c75ea74cc2796adc9257921"

access_token = app_id + "|" + app_secret

page_id = 'nytimes'

def testFacebookPageData(page_id, access_token):

    base = "https://graph.facebook.com/v2.8"
    node = "/" + page_id + "/feed"
    parameters = "/?access_token=%s" % access_token
    url = base + node + parameters

    #Retrieve data
    req = urllib2.Request(url)
    response = urllib2.urlopen(req)
    data = json.loads(response.read())

    print json.dumps(data, indent=4, sort_keys=True)

testFacebookPageData(page_id, access_token)
