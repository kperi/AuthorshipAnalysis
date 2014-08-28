#!/usr/bin/env python


# will need to parse misspellings or get rid of them
# take from: http://swizec.com/blog/measuring-vocabulary-richness-with-python/swizec/2528

from nltk.stem.porter import PorterStemmer
from itertools import groupby
import sys
import os


def words(entry):
    return filter(lambda w: len(w) > 0,
                  [w.strip("0123456789!:,.?(){}[]") for w in entry.split()])
 
def yule(entry):
    # yule's I measure (the inverse of yule's K measure)
    # higher number is higher diversity - richer vocabulary
    d = {}
    stemmer = PorterStemmer()
    for w in words(entry):
        w = stemmer.stem(w).lower()
        try:
            d[w] += 1
        except KeyError:
            d[w] = 1
 
    M1 = float(len(d))
    M2 = sum([len(list(g))*(freq**2) for freq,g in groupby(sorted(d.values()))])
 
    try:
        return (M1*M1)/(M2-M1)
    except ZeroDivisionError:
        return 0

filename = sys.argv[1]
output = sys.argv[2]
output = os.path.splitext(output)[0]

entry = ("").join(open("C:/Users/Daway Chou-Ren/Documents/REU/" + filename, 'r').readlines())
yule_i = round(yule(entry), 4)

with open("C:/Users/Daway Chou-Ren/Documents/REU/" + output + "_file_stats.txt", "a") as myfile:
    myfile.write("yule_i:\t" + str(yule_i) + "\n")

myfile.close()
quit()