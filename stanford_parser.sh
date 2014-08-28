echo 'started' 

REU='C:/Users/Daway Chou-Ren/Documents/REU/'

# INPUT="$REU$1"
# OUTPUT="$REU$2"

cd 'C:/StanfordParser/stanford-parser-full-2014-06-16/'

java -cp "stanford-parser.jar;stanford-parser-3.4-models.jar" \
	edu.stanford.nlp.parser.lexparser.LexicalizedParser \
	-retainTMPsubcategories -outputFormat "penn" \
	edu/stanford/nlp/models/lexparser/englishPCFG.ser.gz \
	"C:/Users/Daway Chou-Ren/Documents/REU/sampleSplit/facebookMessages/ann/ann_7.txt" \
	> "C:/Users/Daway Chou-Ren/Documents/REU/sampleoutput.txt"

# java -cp "stanford-parser.jar;stanford-parser-3.4-models.jar;./" ParserDemo

# echo edu.stanford.nlp.tagger.maxent.MaxentTagger  -textFile \
# 			"$REU"federalistRParsed/hamilton/hamilton_1.txt -outputFormat tsv -outputFormatOptions lemmatize \
# 			> "$REU"pos_tagged/1test.txt

echo 'done'

