from __future__ import division
import string
import os
from os import path

CONST_NUM_LABELS = 200

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

# fromDir = sys.argv[1]
# toDir = sys.argv[2]

fromDir = 'samples/purdue_texts.txt'
toDir = 'sampleSplit/purdueTexts/'

texts = open(reu_path + fromDir, 'r')

first_line = texts.readline()
split_first = str.split(first_line, "\t")
label = split_first[1]
message = split_first[2]
time = split_first[3]

labels = []
# CONST_NUM_LABELS is arbitrary
counter_by_label = [0] * CONST_NUM_LABELS

counter = 0

for line in texts.readlines():

	split_line = str.split(line, "\t")

	# cannot deal with multi-line texts without serious regexing
	if len(split_line) != 5:
		continue

	toFrom = split_line[4]

	# only want to store outgoing messages
	if toFrom.lower().rstrip() == "incoming":
		continue

	label = split_line[1]
	if (label != '1' and label != '3' and label != '4' and label != '6' 
		and label != '8' and label != '13'):
		continue

	message = split_line[2]

	date = split_line[3]
	time = str.split(date, " ")[1]
	hour = str.split(time, ":")[0]
	minute = str.split(time, ":")[1]

	timeOfDay = float(int(hour) * 60 + int(minute)) / 3600


	outputDir = reu_path + toDir + label

	if not os.path.exists(outputDir):
		os.makedirs(outputDir)


	# num_files = len([name for name in os.listdir(outputDir + '/')])
	counter = counter_by_label[int(label)]
	output = open(outputDir + '/' + label + '_' + str(counter // 10 + 1) + '.txt', 'a')
	counter_by_label[int(label)] = counter + 1

	
	# output.write(str(timeOfDay) + "|" + message)
	output.write(message + '\n')
