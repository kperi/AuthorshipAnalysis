import sys
import os
import csv

def isfloat(value):
	try:
		float(value)
		return True
	except ValueError:
		return False

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"

fromDir = sys.argv[1]
toDir = sys.argv[2]

with open(reu_path + fromDir, "rb") as csv_file:

	reader = csv.reader(csv_file)
	row_length = len(reader.next())

	for a in range(1, row_length):
		for row in reader:
			for b in range(1, row_length):
				if (a == b):
					print row[b]
		# print a

































	# with open(reu_path + toDir, "wb") as new_csv:
	# 	writer = csv.writer(new_csv)



	# 	writer.writerow(mean_values)
	# 	writer.writerow(std_dev_values)


