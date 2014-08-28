# relativizes a frequnecy table that is split with " =:= "
# new table is split with \t

import sys
import string
import os

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

fromDir = sys.argv[1]
file_name = sys.argv[2]
file_no_ext = os.path.splitext(file_name)[0]
toDir = sys.argv[3]

f = open(reu_path + fromDir + file_no_ext + "_freq_table.txt", 'r')

output = open(reu_path + toDir + file_no_ext + "_rel_freq_table.txt", 'w')
sum_freqs = 0;

for line in f.readlines():
	line = line.lower()
	fields = line.split(" =:= ") # (word, =, freq)
	sum_freqs += float(fields[1])

f.close()


f = open(reu_path + fromDir + file_no_ext + "_freq_table.txt", 'r')

for line in f.readlines():
	line = line.lower()
	fields = line.split(" =:= ") # (freq, word, tag, num files)
	freq_string = "{:.6f}".format(float(fields[1])/sum_freqs) 
	output.write(fields[0] + "\t" + str(freq_string) + "\n")
