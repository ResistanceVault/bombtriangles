#!/usr/bin/env python
 
from subprocess import call
call("clear")
import sys
import urllib2
import urllib
import httplib
from xml.etree import ElementTree as etree
import re
import sys
import os

class wolfram(object):    
    def __init__(self, appid):        
        self.appid = appid
        self.base_url = 'http://api.wolframalpha.com/v2/query?'
        self.headers = {'User-Agent':None}

    def _get_xml(self, ip):
        url_params = {'input':ip, 'appid':self.appid}
        data = urllib.urlencode(url_params)
        print data
        req = urllib2.Request(self.base_url, data, self.headers)
        xml = urllib2.urlopen(req).read()
        return xml

    def _xmlparser(self, xml):
        data_dics = {}
        tree = etree.fromstring(xml)
        #retrieving every tag with label 'plaintext'
        for e in tree.findall('pod'):
            for item in [ef for ef in list(e) if ef.tag=='subpod']:
                for it in [i for i in list(item) if i.tag=='plaintext']:
                    if it.tag=='plaintext':
                        data_dics[e.get('title')] = it.text
        return data_dics

    def search(self, ip):
        xml = self._get_xml(ip)
        result_dics = self._xmlparser(xml)
         
        print 'Available Titles', '\n'
        titles = dict.keys(result_dics)
        for ele in titles : print '\t' + ele
        print '\n'
        tryAgain = 'y'
        while tryAgain == 'y':
                s = raw_input('Choose Pod Title: (type quit to terminate) ')
                if s == 'quit': quit()

                while (s not in titles):
                        if s == 'quit': quit()
                        print 'Not Valid Title'
                        s = raw_input('Choose Pod Title Again: ')
                print result_dics[s]
                tryAgain = raw_input('\nTry other pod title(y/n): ')
        print '\nTerminate the query'

    def searchSolution(self, ip):
        xml = self._get_xml(ip)
        result_dics = self._xmlparser(xml)
        return result_dics["Solution"]

#x1 = 0.0
#y1 = 0.0
#x2=135.0
#y2=153.0

# assign appid for wolfram
appid = os.getenv('WOLFRAM_APPID')
if appid == "":
    print "Env variable WOLFRAM_APPID not found, add it into your .bashrc file appending EXPORT WOLFRAM_APPID=xxx"
    print "Appid must be created from wolfram website after registration"
    exit(1)

print "Using WOLFRAM appid "+appid

# Check input params , if wrong print message and exit
if len(sys.argv) < 6:
    print "Usage: getpath.py x1 y1 x2 y2 steps"
    exit(1)

# Asssign input params and print on screen
x1 = float(sys.argv[1])
y1 = float(sys.argv[2])
x2 = float(sys.argv[3])
y2 = float(sys.argv[4])
x_steps = float(sys.argv[5])

print "Input x1 : "+str(x1)
print "Input y1 : "+str(y1)
print "Input x2 : "+str(x2)
print "Input y2 : "+str(y2)
print "X Steps : "+str(x_steps)

# Get the m of the input rect
m_original_n = ( y1 - y2 )
m_original_d = ( x1 - x2 )

# get the q o the input rect
q_original = (x1*y2 - x2*y1) / ( x1- x2)

# now with m and q I can build the equation of the rect
eq_original = "y = ("+str(m_original_n)+")/("+str(m_original_d)+")*x+("+str(q_original)+")"

# force the new perpendicular rect to pass to x2 and y2
q_perpendicular = m_original_d/m_original_n*x2+y2
# Build an equation of a perpendicular rect to the input one, m mst be sign changed and reciproco
eq_perpendicular = "y = ("+str(m_original_d)+")/("+str(m_original_n)+")*-x+("+str(q_perpendicular)+")"

print "m="+str(m_original_n)+"/"+str(m_original_d)
print "q="+str(q_original)
print "eq_original "+eq_original
print "eq_perpendicular "+eq_perpendicular

# prepare the equation system for wolfram
wolf_query = "y="+str(y1)
wolf_query += ","
wolf_query += eq_perpendicular
print wolf_query

query = wolf_query
print 'I am asking for: ', query
w = wolfram(appid)
solution = w.searchSolution(query)
print("Solution: "+solution)
x = re.search(r"([0-9\.-]+),[^0-9]*([0-9\.]+)", solution)
parallel_x_interception = float(x.group(1))
print "parallel_x_interception:"+str(parallel_x_interception)

#x_central_triangle = 308.4
#x_steps = 64.0
x_single_step = (parallel_x_interception - x1) / x_steps
print "Single step on X axys is:"+str(x_single_step) + "("+str(parallel_x_interception - x1)+"/"+str(x_steps)+")"

x_counter = 0
x_perp = x1
asmcode = "dc.w "
while x_counter<=64:
    #x_perp = x_counter * x_single_step
    print "Xperp "+str(x_perp)

    # get the equation of the perpendicular line passing to (xperp,y1)
    #q = -1.0*(m_original_d/m_original_n)*x_perp+y1
    q_perpendicular = m_original_d/m_original_n*x_perp+y1
    eq_perpendicular = "y = ("+str(m_original_d)+")/("+str(m_original_n)+")*-x+("+str(q_perpendicular)+")"
    #eq_parallel = "y = "+str(m_original_d)+"/"+str(m_original_n)+"*x*-1+("+str(q)+")"

    # prepare the equation system for wolfram
    wolf_query = eq_original
    wolf_query += ","
    wolf_query += eq_perpendicular
    print wolf_query

    query = wolf_query
    print 'I am asking for: ', query
    w = wolfram(appid)
    solution = w.searchSolution(query)
    print("Solution: "+solution)

    x = re.search(r"([0-9\.-]+),[^0-9-]*([0-9\.-]+)", solution)
    x_result = round(float(x.group(1)))
    print(x_result)
    y_result = round(float(x.group(2)))
    print(y_result)

    asmcode+=str(int(x_result))
    asmcode+=","
    asmcode+=str(int(y_result))
    asmcode+=","

    x_counter = x_counter+1;
    x_perp += x_single_step

print asmcode


exit(0)
