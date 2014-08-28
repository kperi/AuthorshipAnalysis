#!/bin/bash

# takes 3 flags: parse, fast, caseless
# parse adds parse tree pairs (very slow)
# to speed up, specify "fast", accuracy decreases however
# for tagging, you can specify "caseless"

echo ''
echo 'starting'
echo ''

parse=0
fast=0
caseless=0
for var in "$@"
do 
	if [ $var == "parse" ]
	then
		parse=1
	elif [ $var == "fast" ]
	then
		fast=1
	elif [ $var == "caseless" ]
	then
		caseless=1
	fi
done


REU='C:/Users/Daway Chou-Ren/Documents/REU/'

T="$(date +%s)"
T_FrequencyTable=0
T_relativise_freq_table=0
T_pos_tag=0
T_syn_parse=0
T_yules_i=0
T_simpson_d=0

find "$REU"sampleRParsed/ -name "*.*" -exec rm -f '{}' +
find "$REU"pos_tagged/ -name "*.txt" -exec rm -f '{}' +
if [ $parse -eq 1 ]
then
	find "$REU"parseTrees/ -name "*.txt" -exec rm -f '{}' +
fi
find "$REU"sampleOutput/ -name "*.txt" -exec rm -f '{}' +
find "$REU"freqTables/ -name "*.txt" -exec rm -f '{}' +
find "$REU"relFreqTables/ -name "*.txt" -exec rm -f '{}' +
find "$REU"posUnigrams/ -name "*.txt" -exec rm -f '{}' +
find "$REU"posBigrams/ -name "*.txt" -exec rm -f '{}' +
find "$REU"data/ -name "*.txt" -exec rm -f '{}' +

find "$REU"normalized/ -name "*.txt" -exec rm -f '{}' +


echo ''
echo '########################################################'
echo ''
echo 'parsing corpus'
echo ''


cd 'C:/Program Files/R/R-3.0.2/bin/x64'
T_parse_corpus="$(date +%s)"
# ./rscript "$REU"parse_corpus.r sampleSplit/$1/ sampleRParsed/ data/
./rscript "$REU"parse_corpus_texts.r sampleSplit/$1/ sampleRParsed/ data/
T_parse_corpus="$(($(date +%s)-T_parse_corpus))"
echo ''



echo '########################################################'
echo ''
echo 'tagging and parsing sentences'
echo ''

if [ $fast -eq 0 ] # slow parsing
then
	cd "$REU"sampleRParsed/
	FILES="$(find -type f -name '*.txt')"

	# batch tagging, tab separated columns
	T_temp="$(date +%s)"
	cd 'C:/StanfordPOS/'
	javac -cp "stanford-postagger-3.3.1.jar;stanford-postagger-3.3.1-src.jar;./" TaggerDemo.java

	if [ $caseless -eq 1 ]
	then 
		java -cp "stanford-postagger-3.3.1.jar;stanford-postagger-3.3.1-src.jar;./" TaggerDemo \
			english-caseless-left3words-distsim.tagger $1/ pos_tagged/
	else
		java -cp "stanford-postagger-3.3.1.jar;stanford-postagger-3.3.1-src.jar;./" TaggerDemo \
			english-left3words-distsim.tagger $1/ pos_tagged/
	fi

	T_pos_tag="$(($(date +%s)-T_temp))"
	echo ''

	# FILES="$(find -type f -name '*.txt')"

	# cd "$REU"sampleRParsed/
	# FILES="$(find -type f -name '*.txt')"

	# T_temp="$(date +%s)"
	# cd 'C:/StanfordPOS/'
	# for f in $FILES
	# 	do

	# 		echo ''

	# 		b=$(basename "$f")
	# 		echo "$b"
	# 		java -cp stanford-postagger.jar edu.stanford.nlp.tagger.maxent.MaxentTagger \
	# 			-model models/english-caseless-left3words-distsim.tagger -textFile \
	# 			"$REU"sampleRParsed/"$b" -outputFormat tsv -outputFormatOptions lemmatize \
	# 			> "$REU"pos_tagged/"$b"
	# done
	# T_pos_tag="$(($(date +%s)-T_temp))"
	# echo ''

	# parse separately by loading a parser (not shiftreduce)
	if [ $parse -eq 1 ]
	then
		echo '########################################################'
		echo ''
		echo 'syntax parsing'
		echo ''

		T_temp="$(date +%s)"
		cd "C:/StanfordParser/stanford-parser-full-2014-06-16/"
		javac -cp "stanford-parser.jav;stanford-parser-3.4-models.jar;./" ParserDemo.java
		java -cp "stanford-parser.jar;stanford-parser-3.4-models.jar;./" ParserDemo \
			$1/ parseTrees/ 
		T_syn_parse="$(($(date +%s)-T_temp))"
		echo ''
	fi

# fast parsing -- combine tagging and parsing into ShiftReduceDemo
else  # fast -eq 1
	T_temp="$(date +%s)"
	cd "C:/StanfordNLP/"
	jar_part_1="stanford-corenlp-3.4.jar;stanford-corenlp-3.4-models.jar;xom.jar;joda-time.jar;"
	jar_part_2="jollyday.jar;emjl-0.23.jar;stanford-srparser-2014-07-01-models.jar;"
	jar_part_3="stanford-postagger-3.3.1.jar;stanford-corenlp-caseless-2013-11-12-models.jar;./"
	javac -cp $jar_part_1$jar_part_2$jar_part_3 ShiftReduceDemo.java

	if [ $caseless -eq 1 ]
	then 
		java -cp $jar_part_1$jar_part_2$jar_part_3 ShiftReduceDemo $1/ pos_tagged/ parseTrees/ \
			"caseless"
	else
		java -cp $jar_part_1$jar_part_2$jar_part_3 ShiftReduceDemo $1/ pos_tagged/ parseTrees/ \
			"notcaseless"
	fi

	T_syn_parse="$(($(date +%s)-T_temp))"

	T_pos_tag=$((T_syn_parse / 2))
	T_syn_parse=$((T_syn_parse / 2))
	echo ''


fi


echo '########################################################'
echo ''
echo 'part of speech frequencies'
echo ''


cd 'C:/Program Files/R/R-3.0.2/bin/x64'
T_temp="$(date +%s)"
./rscript "$REU"pos_tag_freqs.r pos_tagged/ data/data.csv data/data.csv posUnigrams/
T_pos_freqs="$(($(date +%s)-T_temp))"
echo ''

cd 'C:/Program Files/R/R-3.0.2/bin/x64'
T_temp="$(date +%s)"
./rscript "$REU"pos_bigram.r posUnigrams/ data/data.csv data/data.csv posBigrams/
T_pos_freqs="$(($(date +%s)-T_temp))"
echo ''





COUNTER=0
FILENAMES=

### java freq tables
cd 'C:/Users/Daway Chou-Ren/Workspace/wordFrequencies/src/'
javac FrequencyTable.java

cd "$REU"sampleSplit/$1'/'

FILES="$(find -type f -name '*.txt')"

for f in $FILES
	do

		b=$(basename "$f")
		FILENAMES="$FILENAMES|$b"
		COUNTER=$(($COUNTER+1))

		echo '########################################################'
		echo ''
		echo "$b"
		echo '----------------------------'
		echo ''

		echo 'building frequency tables'
		cd 'C:/Users/Daway Chou-Ren/Workspace/wordFrequencies/src/'
		T_temp="$(date +%s)"

		java FrequencyTable words "C:/Users/Daway Chou-Ren/Documents/REU/sampleRParsed/" \
			"$b" freqTables/ sampleOutput/

		java FrequencyTable bigrams "C:/Users/Daway Chou-Ren/Documents/REU/posBigrams/" \
			"$b" posBigrams/freqTables/ posBigrams/stats/

		java FrequencyTable "parse bigrams" "C:/Users/Daway Chou-Ren/Documents/REU/parseTrees/" \
			"$b" parseTrees/freqTables/ parseTrees/stats/


		T_temp="$(($(date +%s)-T_temp))"
		T_FrequencyTable="$((T_FrequencyTable+T_temp))"
		echo ''

		

		echo 'relativising frequency tables'
		T_temp="$(date +%s)"

		python.exe C:/Users/'Daway Chou-Ren'/Documents/REU/relativise_freq_table.py \
			freqTables/ "$b" relFreqTables/

		python.exe C:/Users/'Daway Chou-Ren'/Documents/REU/relativise_freq_table.py \
			posBigrams/freqTables/ "$b" posBigrams/relFreqTables/

		python.exe C:/Users/'Daway Chou-Ren'/Documents/REU/relativise_freq_table.py \
			parseTrees/freqTables/ "$b" parseTrees/relFreqTables/

		T_temp="$(($(date +%s)-T_temp))"
		T_relativise_freq_table="$((T_relativise_freq_table+T_temp))"
		echo ''

		echo ''
done

echo '########################################################'
echo ''
echo 'merging file stats to csv file'
echo ''
cd 'C:/Python27/'
T_stats_to_csv="$(date +%s)"
python.exe C:/Users/'Daway Chou-Ren'/Documents/REU/stats_to_csv.py  \
	sampleOutput/ $FILENAMES data/data.csv file_stats
python.exe C:/Users/'Daway Chou-Ren'/Documents/REU/stats_to_csv.py  \
	parseTrees/relFreqTables/ $FILENAMES data/data.csv  rel_freq_table
T_stats_to_csv="$(($(date +%s)-T_stats_to_csv))"
echo ''
# fi
	

echo '########################################################'
echo ''
echo 'calculating feature statistics'
echo ''
cd 'C:/Program Files/R/R-3.0.2/bin/x64'
T_csv_stats="$(date +%s)"
./rscript "$REU"csv_stats.r \
	data/data.csv data/data_stats.csv
T_csv_stats="$(($(date +%s)-T_csv_stats))"
echo ''

echo '########################################################'
echo ''
echo 'postprocessing'
echo ''
cd 'C:/Program Files/R/R-3.0.2/bin/x64'
T_postprocessing="$(date +%s)"
./rscript "$REU"postprocess_data_stats.r \
	data/data_stats.csv data/data_stats.csv
T_postprocessing="$(($(date +%s)-T_postprocessing))"
echo ''

echo '########################################################'
echo ''
echo 'normalizing features'
echo ''
cd 'C:/Program Files/R/R-3.0.2/bin/x64'
T_test_data="$(date +%s)"
./rscript "$REU"normalize_csv.r \
	data/data_stats.csv normalized/$1/
T_test_data="$(($(date +%s)-T_test_data))"
echo ''


echo '########################################################'
echo ''

T="$(($(date +%s)-T))"
echo -e "processed $COUNTER documents"
echo -e "entire process: \t\t ${T} seconds"

echo -e "parsing corpus: \t\t ${T_parse_corpus} seconds"
echo -e "tagging parts of speech: \t ${T_pos_tag} seconds"
echo -e "syntax parsing: \t\t ${T_syn_parse} seconds"
echo -e "part of speech frequencies: \t ${T_pos_freqs} seconds"

echo -e "building frequency tables: \t ${T_FrequencyTable} seconds"
echo -e "relativising frequency tables: \t ${T_relativise_freq_table} seconds"
# echo -e "calculating yules i: \t\t ${T_yules_i} seconds"
# echo -e "calculating simpson d: \t\t ${T_simpson_d} seconds"

echo -e "merging file stats to csv file:  ${T_stats_to_csv} seconds"
echo -e "calculating feature statistics:  ${T_csv_stats} seconds"
echo -e "normalizing features:\t\t ${T_test_data} seconds"

echo $(date +"%T")
echo -e "\a"