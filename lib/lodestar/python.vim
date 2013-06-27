" ==============================================================
" File:         python.vim
" Description:  Python functions used by lodestar
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
"
" ==============================================================

if lodestar#guard('g:loaded_LodestarPython') | finish | endif


" Python v2.7 {{{1 Used for a variety of different functions
" ==============================================================
python << endpython

import vim
import urllib2, json, os.path
from HTMLParser import HTMLParser
from collections import defaultdict

def decode(member):
    """ Converts json object to usable Vim object 

    In Python 2.7 a json object, by default, returns all string
    representations in unicode. The 'u' prefix makes equating this 
    value to a vim string difficult. Loading this function as the
    object hook in the json module's load function solves this problem.

    """
    if isinstance(member, dict):
        return { decode(k) : decode(v) for k, v in member.iteritems() }
    elif isinstance(member, list):
        return [ decode(k) for k in member ]
    elif isinstance(member, unicode):
        return member.encode('utf-8')
    else:
        return member

def abs_path(base, rel = ''):
    """ Finds the absolute path of rel in terms of base

    Because the links in the manifest files present in lodes
    are defined relative to the current lode, it is necessary
    to expand the path names for proper naming purposes.

    """
    base_path = os.path.expanduser(base)
    return os.path.abspath(base_path + '/' + rel)

class WikiHandler(HTMLParser):
    """ Used to interact with WikiMedia's API

    Handles querying, searching, parsing, and
    caching data from Wikimedia. It is assumed the
    user only has read permissions, and will access
    data anonymously (except for the User-Agent which
    should contain the user's email address).  

    Also removes all html tags from any returned content
    for clean printing into a buffer.

    """
    def __init__(self, user_agent):
        # Restart parsing ability
        HTMLParser.__init__(self)
        self.reset()

        # Proper etiquette with using MediaWiki
        self.wiki_opener = urllib2.build_opener()
        self.wiki_opener.addheaders = [('User-agent', 'lodestar')]

        # API Host
        self.host = 'http://en.wikipedia.org/w/api.php'

    def sanitize(self, query):
        """ Return a usable GET query string """
        return query.replace(' ', '+')

    def build_query(self, action, query_parts):
        full_query = self.host
        full_query += '?action={}&format=json'.format(action)
        for param, value in query_parts:
            full_query += '&{}='.format(param)
            if len(value): full_query += value

        return full_query

    def extract_content(self, request):
        """ Convert WikiMedia response to usable JSON format """
        content = {}
        reply = self.wiki_opener.open(request)
        encoding = reply.headers['content-type'].split('charset=')[-1]
        return json.loads(reply.read().decode(encoding), object_hook = decode)

    def query(self, page):
        """ Use API's action=query method for receiving data """
        request = [('prop'   , 'extracts|info'    )
                  ,('inprop' , 'displaytitle'     )
                  ,('exintro', ''                 )
                  ,('titles' , self.sanitize(page))
                  ]

        query_string = self.build_query('query', request)
        response = self.extract_content(query_string)

    def search(self, page):
        """ Use API's action=opensearch method for receiving data """
        request = [('search', self.sanitize(page))]

        query_string = self.build_query('opensearch', request)
        response = self.extract_content(query_string)        

    def parse(self, page):
        """ Use API's action=parse method for receiving data """
        request = [('prop', 'sections|text'    )
                  ,('page', self.sanitize(page))
                  ]

        query_string = self.build_query('parse', request)
        response = self.extract_content(query_string)        

    def cache(self):
        """ Saves contents for current session only. """
        pass

    #Overriden methods
    def handle_starttag(self, tag, attrs):
        """ Find anchor tags referenced in wiki sections """
        pass

    def handle_data(self, data):
        """ Find all non-markup text and save in proper sections """
        pass

endpython
