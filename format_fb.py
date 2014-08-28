import os
import sys
from os import listdir
from os.path import isfile, join
import re

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

# fromDir = sys.argv[1]
# toDir = sys.argv[2]
# counter = sys.argv[3]

toDir = 'samples/facebook/fb_formatted/'
fromDir = 'samples/facebook/fb_raw/'



outputDir = reu_path + toDir
if not os.path.exists(outputDir):
    os.makedirs(outputDir)


samples_path = reu_path + fromDir


for f in listdir(samples_path):
	if (isfile(join(samples_path, f))):

		inputfile = open(join(samples_path, f), 'r')
  		output = open(outputDir + f, 'w')

		for line in inputfile:
			ending = line[-2:-1] # should be last character not including newline
			if (re.match(r'[a-zA-Z0-9]', ending)):
				line = line[:-1] + '.\n'

			output.write(line)
