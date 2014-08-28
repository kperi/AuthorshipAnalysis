#!/bin/bash

cd 'C:/StanfordNLP'

java -cp -jar stanford-corenlp-3.4.jar:stanford-corenlp-3.4-models.jar:xom.jar:joda-time.jar:jollyday.jar:ejml-0.23.jar
-Xmx2g edu.stanford.nlp.pipeline.StanfordCoreNLP -annotators tokenize,ssplit,pos,lemma,ner,parse,dcoref -file $1