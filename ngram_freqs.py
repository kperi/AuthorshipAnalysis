import sys
import string

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"
filename = open(reu_path + sys.argv[1], 'r')


output = open("C:/Users/Daway Chou-Ren/Documents/REU/federalistOutput/" + sys.argv[2], 'w')

# will be a dictionary with tuples as keys, integers as values
pairs = dict()
total_count = 0.0

for line in filename:

  # strip line, break into words
  table = string.maketrans( '', '', )
  line = line.translate(table, ".,?;:\"!$")
  line = line.strip().lower();
  words = line.split(" ")

  # skip this line if there are fewer than two words on it
  if len(words) < 2:
    continue

  # iterate from 0 up to the length of the list minus one (so we don't
  # inadvertently grab elements from beyond the length of the list)
  

  for i in range(len(words) - 1):
    # find the pair; convert to tuple so we can use it as a dictionary key
    pair = tuple(words[i:i+2])
    if pair in pairs:
      pairs[pair] += 1
    else:
      pairs[pair] = 1
    total_count += 1

# print out pairs
for key in sorted(pairs):
  count = pairs[key]
  if count > 1: # only print pairs that occur more than once
    bigram = " ".join(key)
    output.write("%s: %.3f\n" % (bigram, pairs[key] / total_count * 1000))

output.write(str(total_count))