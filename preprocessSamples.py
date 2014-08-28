# encoding: utf-8
import sys
import string
import os
from os import listdir
from os.path import isfile, join

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

fromDir = reu_path + sys.argv[1]

for f in listdir(fromDir):
	newfile = join(fromDir, f)
	print newfile
	for f2 in listdir(newfile):

		inputfile = open(join(newfile, f2), 'r+')
		print inputfile

		for line in inputfile.readlines():
			line2 = line.replace('\xe2', '"')
			line2 = line2.replace(u'\u201d', '"')
			line2 = line2.replace(u'\u2018', '\'')
			line2 = line2.replace(u'\u2019', '\'')
			line2 = line2.replace(u'\u2014', '--')
			inputfile.write(line2)

		inputfile.close()

[”“]
’