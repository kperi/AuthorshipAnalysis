import sys
import string
import os

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

fromDir = reu_path + "parsebigrams.txt"

f = open(fromDir, 'r')

outputfile = open(reu_path + "formattedParseBigrams.txt", 'w')

for line in f.readlines():
	split = line.split(" ") # number part1 part2
	if (split[2] != "\n"):
		newline = "\"" + split[1] + " " + split[2][:-1] + "\", "
		outputfile.write(newline.lower())

outputfile.seek(-1, os.SEEK_END)
outputfile.truncate()
outputfile.seek(-1, os.SEEK_END)
outputfile.truncate()
