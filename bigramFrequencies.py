from __future__ import division
import sys
import nltk
import os
from os import listdir
from os.path import isfile, join
from nltk.probability import FreqDist
import csv

reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"
samples_path = reu_path + 'federalistRParsed/'

# fromDir = sys.argv[1]
# filenames = sys.argv[2]
# toDir = sys.argv[3]

unigramsFrom = 'posUnigrams/'
toDir = 'posBigrams/freqTables/'

def tokenize(sentences):
     for sent in nltk.sent_tokenize(sentences.lower()):
         for word in nltk.word_tokenize(sent):
             yield word




unigrams_path = reu_path + unigramsFrom

# count word length frequencies
for f in listdir(samples_path):
	if (isfile(join(samples_path, f))):
		output_path = reu_path + toDir + f
		output =  open(output_path, "w")

		thisfile = open(samples_path + f).read()
		tokens = tokenize(thisfile)
		
		fd_words = FreqDist([len(w) for w in tokens])

		for a in range(1, 21):
			output.write(str(a) + '\t' + str(fd_words.freq(a)) + '\n')
		count_20 = 0
		# count 20+
		for w in tokens:
			if (len(w) >= 20):
				count_20 += 1
		output.write("20+\t" + str(count_20 / len(fd_words)) + '\n')

# count POS tag frequencies
for f in listdir(unigrams_path):
	if (isfile(join(unigrams_path, f))):
		output_path = reu_path + toDir + f
		output =  open(output_path, "a")

		thisfile = open(unigrams_path + f).read()
		tokens = tokenize(thisfile)

		fd_unigrams = FreqDist(tokens)

		output.write("CC\t" + str(fd_unigrams.freq('cc')) + '\n')
		output.write("CD\t" + str(fd_unigrams.freq('cd')) + '\n')
		output.write("DT\t" + str(fd_unigrams.freq('dt')) + '\n')
		output.write("EX\t" + str(fd_unigrams.freq('ex')) + '\n')
		output.write("FW\t" + str(fd_unigrams.freq('fw')) + '\n')
		output.write("IN\t" + str(fd_unigrams.freq('in')) + '\n')
		output.write("JJ\t" + str(fd_unigrams.freq('jj')) + '\n')
		output.write("JJR\t" + str(fd_unigrams.freq('jjr')) + '\n')
		output.write("JJS\t" + str(fd_unigrams.freq('jjs')) + '\n')
		output.write("LS\t" + str(fd_unigrams.freq('ls')) + '\n')
		output.write("MD\t" + str(fd_unigrams.freq('md')) + '\n')
		output.write("NN\t" + str(fd_unigrams.freq('nn')) + '\n')
		output.write("NNP\t" + str(fd_unigrams.freq('nnp')) + '\n')
		output.write("NNPS\t" + str(fd_unigrams.freq('nnps')) + '\n')
		output.write("NNS\t" + str(fd_unigrams.freq('nns')) + '\n')
		output.write("PDT\t" + str(fd_unigrams.freq('pdt')) + '\n')
		output.write("POS\t" + str(fd_unigrams.freq('pos')) + '\n')
		output.write("PRP\t" + str(fd_unigrams.freq('prp')) + '\n')
		output.write("PRP$\t" + str(fd_unigrams.freq('prp$')) + '\n')
		output.write("RB\t" + str(fd_unigrams.freq('rb')) + '\n')
		output.write("RBR\t" + str(fd_unigrams.freq('rbr')) + '\n')
		output.write("RBS\t" + str(fd_unigrams.freq('rbs')) + '\n')
		output.write("RP\t" + str(fd_unigrams.freq('rp')) + '\n')
		output.write("SYM\t" + str(fd_unigrams.freq('sym')) + '\n')
		output.write("TO\t" + str(fd_unigrams.freq('to')) + '\n')
		output.write("UH\t" + str(fd_unigrams.freq('uh')) + '\n')
		output.write("VB\t" + str(fd_unigrams.freq('vb')) + '\n')
		output.write("VBD\t" + str(fd_unigrams.freq('vbd')) + '\n')
		output.write("VBG\t" + str(fd_unigrams.freq('vbg')) + '\n')
		output.write("VBN\t" + str(fd_unigrams.freq('vbn')) + '\n')
		output.write("VBP\t" + str(fd_unigrams.freq('vbp')) + '\n')
		output.write("VBZ\t" + str(fd_unigrams.freq('vbz')) + '\n')
		output.write("WDT\t" + str(fd_unigrams.freq('wdt')) + '\n')
		output.write("WP\t" + str(fd_unigrams.freq('wp')) + '\n')
		output.write("WP$\t" + str(fd_unigrams.freq('wp$')) + '\n')
		output.write("WRB\t" + str(fd_unigrams.freq('wrb')) + '\n')





