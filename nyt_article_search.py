
from pprint import pprint
import requests
 
# fill in your api key here...
my_api_key = '970d6ce1645d1179aef281aacecc2c30:7:21865567'

outputDir = 'C:/Users/Daway Chou-Ren/Documents/REU/samples/nytimes/'

authors = ['Charles M. Blow', 'David Brooks', 'Frank Bruni', 'Roger Cohen',
			'Gail Collins', 'Ross Douthat', 'Maureen Dowd', 'Thomas L. Friedman',
			'Nicholas Kristof', 'Paul Krugman', 'Joe Nocera']
 
# parameters specifying what data is to be returned
fields = ['web_url', 'snippet', 'lead_paragraph', 'abstract',
		  'print_page', 'blog', 'source', 'multimedia', 'headline',
		  'keywords', 'pub_date', 'document_type', 'news_desk',
		  'byline', 'type_of_material', '_id', 'word_count']
facet_fields = ['source', 'section_name', 'document_type',
				'type_of_material', 'day_of_week']
 
# get request the server
# for (a in range(1, len(authors))):


resp = requests.get('http://api.nytimes.com/svc/search/v2/articlesearch.json',
					params={'q': 'thomas L. Friedman',
							'page': 0,
							'sort': 'newest',
							'fl': ','.join(fields),
							'facet_field': ','.join(facet_fields),
							'facet_filter': 'true',
							'api-key': my_api_key},
					)
pprint(resp.json()) 
	# output.write(resp.json(), outputDir + authors[a] + '/')