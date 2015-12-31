import xmltodict
import pprint
import json
import sys

p = pprint.PrettyPrinter(indent=4)

for arg in sys.argv[1:]:
    with open(arg) as f:
        s = f.read()
        d = xmltodict.parse(s)
        #print(json.dumps(d, indent=4))

        e = d['feed']['entry']
        for i in e:
            #"@title": "pdf"
            pdf_url = filter(lambda x: '@title' in x and x['@title'] == 'pdf', i['link'])[0]['@href']
            print(pdf_url)
            #print(i)
            #print(i['id'])
            #print(i['title'])
            #print(i['published'])
