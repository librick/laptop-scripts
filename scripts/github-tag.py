#!/usr/bin/env/python3
import requests
import re
import sys

url_re = re.compile('^[a-zA-Z0-9]+\/[a-zA-Z0-9._-]*$')
if len(sys.argv) != 2:
    sys.stderr.write("usage: ./github-tag.py <username>/<repo-name>\n")
    sys.exit(-1)
if url_re.match(sys.argv[1]) == None:
    sys.stderr.write("bad username/repo-name, regex: " + url_re.pattern + "\n")
    sys.stderr.write("usage: ./github-tag.py <username>/<repo-name>\n")
    sys.exit(-1)

url = 'https://github.com/' + sys.argv[1] + '/releases/latest'
r = requests.get(url)
version = r.url.split('/')[-1]
sys.stdout.write(version)
