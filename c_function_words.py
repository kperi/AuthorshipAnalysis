import sys

f = open(sys.argv[1], 'r')
function_words = f.readlines()

output = open(sys.argv[2], 'w')

for line in function_words:
	line = line.lower()
	newline = ("\"" + line.rstrip() + "\", ")
	output.write(newline)