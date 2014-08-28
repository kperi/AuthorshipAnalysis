import sys
import fileinput
import os
import math
import json
from os import listdir
from os.path import isfile, join

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

# fromDir = sys.argv[1]
# toDir = sys.argv[2]

fromDir = 'posBigrams/freqTables/'
toDir = 'posBigrams/stats/'

output_path = reu_path + toDir
output = open(output_path + 'testdict.txt', 'w+')

samples_path = reu_path + fromDir

tf_idf = {}
d = []  # length of num bigrams
maxFreqs = []  # num files
tf = []
relFreq = []
totalFreqs = []

counter = 0
numDocs = 0

for f in listdir(samples_path):
	if (isfile(join(samples_path, f))):


		thisfile = open(samples_path + f, 'r')
		maxFreq = 0
		totalFreq = 0
		freqs = []

		lineCounter = 0
		# print "linecounter: " + str(lineCounter)
		
		for line in thisfile:

			split = line.split(" = ")
			thisFreq = float(split[1])
			thisBigram = str(split[0])

			freqs.append(thisFreq)

			# first file, set up d[]
			if (counter == 0):
				if (thisFreq > 0):
					d.append(1)
				else:
					d.append(0)
			else:
				if (thisFreq > 0):

					d[lineCounter] += 1

			if (thisFreq > maxFreq):
				maxFreq = thisFreq

			totalFreq += thisFreq
			# print "linecounter -: " + str(lineCounter)
			lineCounter += 1
			# print "linecounter +: " + str(lineCounter)


		totalFreqs.append(totalFreq)
		maxFreqs.append(maxFreq)

		counter += 1

numDocs = counter

counter = 0

for f in listdir(samples_path):
	if (isfile(join(samples_path, f))):

		thisfile = open(samples_path + f, 'r')
		maxFreq = 0
		totalFreq = 0
		freqs = []

		lineCounter = 0
		for line in thisfile:

			split = line.split(" = ")
			thisFreq = split[1]
			thisBigram = split[0]

			# if (float(thisFreq) > 1):
			this_tf = 0.5 + 0.5 * float(thisFreq) / float(maxFreqs[counter])
			# else:
			# 	this_tf = 0

			# this_tf = 0.5 * float(thisFreq) / float(maxFreqs[counter])

			# print(d[lineCounter])
			if (d[lineCounter] == 0):
				this_idf = math.log(numDocs / (d[lineCounter] + 1) ) 
				# print(this_tf)
			else:
				this_idf = math.log(numDocs / d[lineCounter] ) 

			if (counter == 0):
				tf_idf[thisBigram] = this_tf * this_idf
			else:
				tf_idf[thisBigram] += this_tf * this_idf

			# print (str(this_tf) + "\t" + str(this_idf))


			lineCounter += 1

		counter += 1

for w in sorted(tf_idf, key = tf_idf.get, reverse=True):
	output.write(w + " =\t" + str(tf_idf[w]) + "\n")

# json.dump(tf_idf, open(output_path + 'testdict.txt','w'))

# for keys, values in tf_idf.items():
# 	output.write(keys)
# 	output.write(values)