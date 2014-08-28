import sys
import string
import math

freqs_path = "C:/Users/Daway Chou-Ren/Documents/REU/federalistOutput/"
file1 = open(freqs_path + sys.argv[1], 'r')
file2 = open(freqs_path + sys.argv[2], 'r')

output = open("C:/Users/Daway Chou-Ren/Documents/REU/federalistOutput/" + sys.argv[3], 'w')

file1_dict = dict()
file2_dict = dict()

for line in file1:
	key = line.split(":")[0]
	value = line.split(":")[1]
	file1_dict[key] = value

for line in file2:
	key = line.split(":")[0]
	value = line.split(":")[1]
	file2_dict[key] = value

for key in sorted(file1_dict.keys()):
	freq1= float(file1_dict.get(key)[:-1])
	if key in file2_dict.keys():
		freq2 = float(file2_dict.get(key))
		# print("%.3f  %.3f   %.3f", freq1, freq2, freq1 - freq2)
		if (abs(freq1 - freq2) > 0.1 and freq1 > 0.1 and freq2 > 0.1):
			output.write("%s: \t\t\t %.3f \t %.3f \t %.3f\n" % (key, freq1, freq2, freq1 - freq2))
