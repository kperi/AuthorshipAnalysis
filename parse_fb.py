


"""
A simple example script to get all posts on a user's timeline.
Originally created by Mitchell Stewart.
<https://gist.github.com/mylsb/10294040>
"""
import facebook
import requests
import sys
# reload(sys)
# sys.setdefaultencoding('utf-8')

def some_action(post):
    """ Here you might want to do something with each post. E.g. grab the
    post's message (post['message']) or the post's picture (post['picture']).
    In this implementation we just print the post's created time.
    """
    print post['created_time']


# You'll need an access token here to do anything.  You can get a temporary one
# here: https://developers.facebook.com/tools/explorer/
access_token = 'CAACEdEose0cBAFzLp5RtA64tYiT4IhRLCfWwZAA4y1ZCXbiw8eq4jwT0gMPGFZB97N2rBfPRZAPnx38Dgihftddj1XwRTKzrQ92QI6gTl3izqmiQvesLFiAdj3TjxtjKQdvU6xw3J3ReYZBpedkDVp5fsz6CMnj6MJnxEcinSqXj8sRL1tWgnARbFRvbXZAwOgCsIAkjayI6s4OVDJyGSYDBjZCXeZC3NiQZD'
# Look at Bill Gates's profile for this example by using his Facebook id.
user = 'me'

graph = facebook.GraphAPI(access_token)
profile = graph.get_object(user)
posts = graph.get_connections(profile['id'], '/friends')

news_feed = graph.get_connections("me", "home", limit=5000, since='2014-07-17T20:00:00')


while True:
	try:
		print len(news_feed['data'])
		for post in reversed(news_feed['data']):
			try:
				print post['from'].get("name").encode('ascii', 'ignore')
				print post.get("message").encode('ascii', 'ignore')
			except:
				e = sys.exc_info()[0]
			print "Created: " + post.get("created_time")
			print "Post ID: " + post.get("id")
			feed_comment = graph.get_connections(post.get("id"), "comments", limit = 5)
			print str(len(feed_comment['data'])) + " comments"
			for comment in feed_comment['data']:
				try:
					print "++++"
					print comment['from'].get("name").encode('ascii', 'ignore')
					print comment.get("message").encode('ascii', 'ignore')
					print "Created: " + comment.get("created_time")
				except:
					e = sys.exc_info()[0]
			print "---------------------------------"

		print "####################################"
		print "####################################"
		print "####################################"
		print "####################################"
		news_feed = requests.get(news_feed['paging']['next']).json()

	except KeyError:
		break