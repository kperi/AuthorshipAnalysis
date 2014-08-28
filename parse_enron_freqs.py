import sys
import string

f = open("C:/Users/Daway Chou-Ren/Documents/REU/testoutput.txt", 'r')

output = open("C:/Users/Daway Chou-Ren/Documents/REU/enron_freqs.txt", 'w')
sum_freqs = 0;

for line in f.readlines():
	line = line.lower()
	fields = line.split(" ") # (freq, word, tag, num files)
	sum_freqs += int(fields[2])

f.close()


f = open("C:/Users/Daway Chou-Ren/Documents/REU/testoutput.txt", 'r')

for line in f.readlines():
	line = line.lower()
	fields = line.split(" ") # (freq, word, tag, num files)
	freq_string = "{:.4f}".format(float(fields[2])/sum_freqs) 
	output.write(fields[0] + " " + str(freq_string) + "\n")
