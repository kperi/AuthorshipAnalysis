import sys

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"
inputFile = sys.argv[1]
filename = open(reu_path + inputFile, 'r')

num_lines = 0
num_blank_lines = 0
newline_bool = 0

for line in filename:
	print len(line)
	# print line
	if line in ['\n', '\r\n']:
		num_blank_lines += 1
	num_lines += 1



with open("C:/Users/Daway Chou-Ren/Documents/REU/" + inputFile[:-4] + "_file_stats.txt", "w") as myfile:
    myfile.write("lines:\t" + str(num_lines) + "\n")
    myfile.write("blank lines:\t" + str(num_blank_lines) + "\n")