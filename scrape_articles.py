import os
import urllib2
import cookielib
import re
import htmlentitydefs
import codecs
import time
from BeautifulSoup import BeautifulSoup

print 'a'
URL_REQUEST_DELAY = 1
BASE = 'http://www.nytimes.com'
TXDATA = None
TXHEADERS = {'User-agent': 'Mozilla/4.0 (compatible; MSIE 5.5; Windows NT)'}
OUTPUT_FILE = 'nyt_articles.txt'

def request_url(url, txdata, txheaders):
	"""Gets a webpage's HTML."""
	req = Request(url, txdata, txheaders)
	handle = urlopen(req)
	html = handle.read()
	return html

def remove_html_tags(data):
	"""Removes HTML tags"""
	p = re.compile(r'< .*?>')
	return p.sub('', data)

def unescape(text):
	"""
	Converts HTML character codes to Unicode code points.

	@param text the HTML (or XML) source text in any encoding.
	@return The plain text, as a Unicode string, if necessary.
	"""
	def fixup(m):
		text = m.group(0)
		if text[:2] == "&#":
			try:
				if text[:3] == "&#x":
					return unichr(int(text[3:-1], 16))
				else:
					return unichr(int(text[2:-1]))
			except ValueError:
				pass
		else:
			try:
				text = unichr(htmlentitydefs.name2codepoint[text[1:-1]])
			except KeyError:
				pass
		return text
	return re.sub("&#?\w+;", fixup, text)


urlopen = urllib2.urlopen
Request = urllib2.Request

# Install cookie jar in opener for fetching URL
cookiejar = cookielib.LWPCookieJar()
opener = urllib2.build_opener(urllib2.HTTPCookieProcessor(cookiejar))
urllib2.install_opener(opener)

html = request_url('http://global.nytimes.com/', TXDATA, TXHEADERS)
# Use BeautifulSoup to easily navigate HTML tree
soup = BeautifulSoup(html)

# Retrieves html from each url on NYT Global homepage under "story" divs
# with h2, h3, or h5 headlines
urls = []
for story in soup.findAll('article', {'class': 'story'}):
	# print story
	for hTag in story.findAll({'h2': True, 'h3': True, 'h5': True}, recursive=False):
		if hTag.find('a'):
			urls.append(hTag.find('a')['href'])

# print "urls: " + str(urls)

# Removes URLs that aren't news articles.
# Create a copy of list b/c
# you can't modify a list while iterating over it.
for url in urls[:]:
	if not url.startswith(BASE):
		urls.remove(url)

# print "urls: " + str(urls)

# Extracts headline, byline, dateline and content; outputs to file
if os.path.exists(OUTPUT_FILE):
	os.remove(OUTPUT_FILE)
output = codecs.open(OUTPUT_FILE, 'a', 'utf-8')

counter = 0
for url in urls:
	print url
	content = ''
	html = request_url(url, TXDATA, TXHEADERS)

	html = unicode(html, 'utf-8')
	if (counter == 0):
		output.write(html)
		counter += 1
	soup = BeautifulSoup(html)
	# Gets HTML from single page link if article is > 1 page
	# if soup.find('li', {'class': 'singlePage'}):
	# 	single = soup.find('li', {'class': 'singlePage'})
	# 	html = request_url(BASE + single.find('a')['href'], TXDATA, TXHEADERS)
	# 	html = unicode(html, 'utf-8')
	# 	soup = BeautifulSoup(html)
	# 	# print html

	if not soup.find('header'):
		continue
	headline = soup.find({'class': 'story-header'}).renderContents()
	print headline
	output.write(unicode(headline + "\n", 'utf-8'))

	byline = soup.find('byline').find('h6').renderContents()
	byline = remove_html_tags(byline)
	print byline
	output.write(unicode(byline + "\n", 'utf-8'))

	dateline = soup.find('h6', {'class': 'dateline'}).renderContents()
	output.write(unicode(dateline, 'utf-8'))

	for p in soup.findAll('p', {'class': None, 'style': None}):
		# Removes potential ad at the bottom of the page.
		if p.findParents('div', {'class': 'singleAd'}):
			continue
		# Prevents contents of nested <p> tags from being printed twice.
		if p.findParents('div', {'class': 'authorIdentification'}):
			continue
		content = content + "\n\n" + p.renderContents().strip()
	content = remove_html_tags(content)
	content = re.sub(" +", " ", content)
	content = unescape(unicode(content, 'utf-8'))
	content = content + "\n\n\n\n"
	output.write(content)

	time.sleep(URL_REQUEST_DELAY)

output.close()