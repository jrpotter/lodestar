" ==============================================================
" File:         Python.vim
" Maintainer:   Joshua Potter <jrpotter@live.unc.edu>
" License:      Apache License, Version 2.0
" Description:  Python functions used by lodestar
"
" ==============================================================

if lodestar#guard('g:loaded_LodestarPython') | finish | endif


" Python v2.7 {{{1 Used for a variety of different functions
" ==============================================================
python << endpython

import vim
import pickle, json, shutil
import urllib2, os, os.path
from HTMLParser import HTMLParser
from collections import defaultdict, deque

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
    return os.path.abspath(os.path.join(base_path, rel))


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
    def __init__(self, user):
        HTMLParser.__init__(self)

        # API Host
        self.host = 'http://en.wikipedia.org/w/api.php'

        # Proper etiquette with using MediaWiki
        self.opener = urllib2.build_opener()
        self.opener.addheaders = [('User-agent', 'lodestar/{}'.format(user))]

        # Set up for queries
        self.clear()
        self.cache_dir = vim.eval('g:lodestar#wiki_cache')


    def __enter__(self):
        """ Context manager method """
        if not os.path.isdir(self.cache_dir): 
            os.mkdir(self.cache_dir)

        return self


    def __exit__(self, type, value, traceback):
        """ Context manager method """
        if os.path.isdir(self.cache_dir):
            shutil.rmtree(self.cache_dir)


    def clear(self):
        """ Reset all values """
        self.segments = set()
        self.segment_order = []
        self.search_results = []
        self.current_segment = ''
        self.content = defaultdict(str)


    def sanitize(self, query):
        """ Return a usable GET query string """
        return query.replace(' ', '+')


    def build_query(self, action, query_parts):
        """ Read values and write GET query """
        full_query = self.host
        full_query += '?action={}&format=json'.format(action)
        for param, value in query_parts:
            full_query += '&{}='.format(param)
            if len(value): full_query += value

        return full_query


    def extract_content(self, request):
        """ Convert WikiMedia response to usable JSON format """
        reply = self.opener.open(request)
        encoding = reply.headers['content-type'].split('charset=')[-1]
        return json.loads(reply.read().decode(encoding), object_hook=decode)


    def push_segment(self, segment):
        """ Properly keep track of segment order. """
        try:
            if self.segment_order[-1] != segment:
                self.segment_order.append(segment)
        except IndexError:
            self.segment_order.append(segment)


    def query(self, page):
        """ Use API's action=query method for receiving data """
        request = [('prop'     , 'extracts|info'    )
                  ,('inprop'   , 'displaytitle'     )
                  ,('exintro'  , ''                 )
                  ,('titles'   , self.sanitize(page))
                  ,('redirects', ''                 )
                  ]

        query_string = self.build_query('query', request)
        response = self.extract_content(query_string)

        # Get data
        page_info = response['query']['pages'].popitem()[1]
        self.content['displaytitle'] = page_info['displaytitle']
        self.feed(page_info['extract'])


    def search(self, page):
        """ Use API's action=opensearch method for receiving data """
        request = [('limit', '1'                 )
                  ,('search', self.sanitize(page))
                  ]

        query_string = self.build_query('opensearch', request)
        self.content['search'] = self.extract_content(query_string)[-1]


    def parse(self, page):
        """ Use API's action=parse method for receiving data """
        request = [('prop', 'sections|text'    )
                  ,('page', self.sanitize(page))
                  ]

        query_string = self.build_query('parse', request)
        response = self.extract_content(query_string)        

        # Each anchor marks the next segment
        sections = response['parse']['sections']
        self.segments = set([link['anchor'] for link in sections])
        self.feed(response['parse']['text']['*'])


    def cache(self, path, response):
        """ Saves contents for current session only. """
        if not os.path.isfile(path):
            with open(path, 'wb') as file:
                pickle.dump(response, file)
            return True

        return False


    def uncache(self, path):
        """ Allows quicker accessing of contents already opened. """
        if os.path.isfile(path):
            with open(path, 'rb') as file:
                self.content = pickle.load(path)
            return True

        return False


    def get_data(self, page, parse=False, query=False, search=False):
        """ Main method to get data. """

        # For multiple calls
        self.clear()

        # Check if cached version exists
        filename = page
        if parse:  filename += '_parse'
        if query:  filename += '_query'
        if search: filename += '_search'

        cache_file = os.path.join(self.cache_dir, filename)

        if not self.uncache(cache_file):

            # Build up contents
            if parse:  self.parse(page)
            if query:  self.query(page)
            if search: self.search(page)

            self.cache(cache_file, self.content)

        return self.content


    # Overriden methods
    def handle_starttag(self, tag, attrs):
        """ Find anchor tags referenced in wiki sections """
        attrs = dict(attrs)
        if attrs.get('id') in self.segments:
            self.current_segment = attrs.get('id')
            self.push_segment(self.current_segment)


    def handle_data(self, data):
        """ Find all non-markup text and save in proper sections """
        if len(self.current_segment):
            self.content[self.current_segment] += data
        else:
            self.content['introduction'] += data


endpython
