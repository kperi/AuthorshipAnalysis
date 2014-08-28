from __future__ import division
import string
import os
from os import path

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

# fromDir = sys.argv[1]
# toDir = sys.argv[2]
# counter = sys.argv[3]

toDir = 'samples/textingLingoParsed.txt'
fromDir = 'samples/textingLingo.txt'
counter = 276

output = open(reu_path + toDir, 'w')
inputfile = open(reu_path + fromDir, 'r')

lines = inputfile.readlines()

for line in lines:
	line = line.rstrip()
	output.write(line + "_freq <- numeric(0)\n")

output.write("\n")

for line in lines:
	line = line.rstrip()
	output.write(", \"" + line + "\"")

output.write("\n")

for line in lines:
	line = line.rstrip()
	output.write(line + "_freq[i] <- function_word_freqs[" + str(counter) + "]\n")
	counter += 1

output.write("\n")

for line in lines:
	line = line.rstrip()
	output.write(line + "_freq, ")
