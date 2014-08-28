import sys
import string

# swaps freq and word so that we have (word freq)

f = open("C:/Users/Daway Chou-Ren/Documents/REU/linguistics/all.num.txt", 'r')

output = open("C:/Users/Daway Chou-Ren/Documents/REU/linguistics/all_num_swapped.txt", 'w')
sum_freqs = 0;

for line in f.readlines():
	line = line.lower()
	fields = line.split(" ") # (freq, word, tag, num files)
	output.write(fields[1] + " " + fields[0] + "\n")

f.close()
