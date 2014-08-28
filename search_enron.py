import os
from os import listdir
from os.path import isfile, join
import glob
import re
import sys
import mmap

dashes = "-------------------------\n"

keyword = sys.argv[2].lower()
output = open("C:/Users/Daway Chou-Ren/Documents/REU/enron_searches/" + sys.argv[3], 'w')

enron_path = "C:/Users/Daway Chou-Ren/Documents/REU/enronsent/"
file_pattern = re.compile("^enronsent[0-9][0-9]")

counter = 0
found = 0
hits = 0
results = dashes
previous_line = ""

if (sys.argv[1]):
	onlyfiles = [sys.argv[1]]
else:
	onlyfiles = [f for f in listdir(enron_path) if isfile(join(enron_path, f))]

for filename in onlyfiles:

	if (file_pattern.match(filename) == None):
		continue

	line_counter = 0

	f = open(os.path.join(enron_path, filename))
	print "here"
	for line in f:
		line_counter += 1

		if keyword in line.lower():
			found = 1
			hits += 1
			print ("\"" + keyword + "\" " + "found at line " + str(line_counter) + " in file " + filename)
			results += filename + ": " + str(line_counter) + "\n\n"
			results += previous_line + line + next(f, '')
			results += "\n" + dashes

		previous_line = line





print ("hits: " + str(hits))
output.write(results)
if found == 0:
	print ("\"" + keyword + "\" was not found")