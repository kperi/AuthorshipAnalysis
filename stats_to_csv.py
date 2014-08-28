import sys
import fileinput
import os

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

fromDir = sys.argv[1]
filenames = sys.argv[2]
toDir = sys.argv[3]
filetype = sys.argv[4]

output_path = reu_path + toDir

output = open(output_path, 'r+')

new_output = ""

split_files = filenames.split("|")[1:]   # first split is blank


for a in range(0, len(split_files)):

	file_no_ext = os.path.splitext(split_files[a])[0]
	this_file = open(reu_path + fromDir + file_no_ext + "_" + filetype + ".txt", 'r')

	labels_to_append = ""
	values_to_append = ""

	for line in this_file:

		tokens = line.split("\t")

		thisLabel = ", \"" + tokens[0] + "\""
		labels_to_append += thisLabel

		thisValue = "," + tokens[1]
		values_to_append += thisValue.rstrip()

	if (a == 0): 
		existing_labels = output.readline()
		new_labels = existing_labels.rstrip() + labels_to_append
		new_output += new_labels + "\n"

	existing_values = output.readline()
	new_values = existing_values.rstrip() + values_to_append
	new_output += new_values + "\n"

	this_file.close()

output.seek(0)
output.truncate()
output.write(new_output)
output.close()
