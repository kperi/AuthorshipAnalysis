# splits facebook messages from subjects given in args[1] separated by '|'
# splits into groups given by args[3]
# writes files to sampleSplit/args[2]

import sys
import os
from os.path import isfile, join
import re
import shutil

CONST_GROUPING_SIZE = int(sys.argv[3])
line_endings = ['.', ',', '?', '!', ':', ';', '-', '+']

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

fromDir = "samples/facebookMessages/allMessages.txt"
toDir = "sampleSplit/" + sys.argv[2]

outputDir = reu_path + toDir
if not os.path.exists(outputDir):
	os.makedirs(outputDir)
for folder in os.listdir(outputDir):
	folderpath = os.path.join(outputDir, folder)
	shutil.rmtree(folderpath)

labels = sys.argv[1].split("|")
for label in labels:
	subfolder = outputDir + label[0:label.index(' ')] + '/'
	if not os.path.exists(subfolder):
		os.makedirs(subfolder)


label_counters = []
for label in labels:
	label_counters.append(0)

samples_path = reu_path + fromDir
inputfile = open(samples_path, 'r')

which_label = ""
for line in inputfile.readlines():

	if (which_label != ""):
		name = which_label[0:which_label.index(' ')]
		output = open(outputDir + name + '/' + name + '_'
			+ str(label_counters[label_index] // CONST_GROUPING_SIZE + 1) + '.txt', 'a')
		if (line[ len(line)-2 : len(line)-1 ] in line_endings):
			output.write(line)
		else:
			line = line[:-1] + '.\n'
			output.write(line)

	which_label = ""

	label_index = 0
	for label in labels:

		pattern = label + '[A-Z]'
		if re.match(label, line):
			which_label = label
			label_counters[label_index] += 1
			break;

		label_index += 1

os.system('\a')