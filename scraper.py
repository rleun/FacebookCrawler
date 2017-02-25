
import urllib2
import json
import datetime
import csv
import time

#Access token
app_id = "372396713160018"
app_secret = "0a79efd41c75ea74cc2796adc9257921"

access_token = app_id + "|" + app_secret

page_id = 'buzzfeed'

def testFacebookPageData(page_id, access_token, num_statuses):

    base = "https://graph.facebook.com/"
    node = "/" + page_id + "/feed"
    parameters = "/?fields=message,link,created_time,type,name,id,likes.limit(1).summary(true),comments.limit(1).summary(true),shares&limit=%s&access_token=%s" % (num_statuses, access_token)
    url = base + node + parameters

    #Retrieve data
    req = urllib2.Request(url)

    #Stalls if request error
    success = False
    while success is False:
        try:
            response = urllib2.urlopen(req)
            if response.getcode() == 200:
                success = True
        except Exception, e:
            print # coding=utf-8
            time.sleep(5)
            print "Error for URL %s: %s" % (url, datetime.datetime.now())

    data = json.loads(response.read())

    return data

test_status = testFacebookPageData(page_id, access_token, 1)["data"][0]
#testFacebookPageData(page_id, access_token)
print json.dumps(test_status, indent=4, sort_keys=True)
