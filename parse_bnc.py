import sys
import string
import os

f = open(os.path.join("C:/Users/Daway Chou-Ren/Documents/REU/linguistics/", sys.argv[1]), 'r')

output = open(os.path.join("C:/Users/Daway Chou-Ren/Documents/REU/linguistics/", sys.argv[2]), 'w')
sum_freqs = 0;

for line in f.readlines():
	line = line.lower()
	fields = line.split(" ") # (freq, word, tag, num files)
	sum_freqs += int(fields[0])

f.close()


f = open(os.path.join("C:/Users/Daway Chou-Ren/Documents/REU/linguistics/", sys.argv[1]), 'r')

for line in f.readlines():
	line = line.lower()
	fields = line.split(" ") # (freq, word, tag, num files)
	freq_string = "{:.4f}".format(float(fields[0])/sum_freqs) 
	output.write(fields[1] + " = " + str(freq_string) + "\n")
