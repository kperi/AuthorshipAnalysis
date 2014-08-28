echo 'started' 

REU='C:/Users/Daway Chou-Ren/Documents/REU/'

# INPUT="$REU$1"
# OUTPUT="$REU$2"

cd 'C:/StanfordPOS/'

# javac -cp stanford-postagger.jar dirTagger.java
java -cp stanford-postagger.jar edu.stanford.nlp.tagger.maxent.MaxentTagger \
			-model models/english-left3words-distsim.tagger  -outputFormat tsv

echo edu.stanford.nlp.tagger.maxent.MaxentTagger  -textFile \
			"$REU"federalistRParsed/hamilton/hamilton_1.txt -outputFormat tsv -outputFormatOptions lemmatize \
			> "$REU"pos_tagged/1test.txt

echo 'done'