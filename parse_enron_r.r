#!/bin/bash/Rscript

options(warn = -1)

library("stylo")


args <- commandArgs(TRUE)
wd <- paste0("C:/Users/Daway Chou-Ren/Documents/REU/", args[1])
setwd(wd)
reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"
samples_path <- args[1]
# output_path <- args[2]
rparsed_path <- args[2]
ngram_size = 1
sample_size = 1

files_dir = paste0(reu_path, samples_path)

##### a vector of files from working directory
files <- list.files(all.files = FALSE, full.names = FALSE, 
	recursive = FALSE, ignore.case = TRUE, include.dirs = FALSE, no.. = FALSE)

# head(files)

corpus <- load.corpus.and.parse(files, corpus.dir = "", markup.type = "html", 
	language = "English.all", splitting.rule = '[!?.,]*[[:space:]]+[\t\n]*', 
	sample.size = 10000, sampling = "no.sampling", sampling.with.replacement = FALSE, 
	features = "w", ngram.size = 1)

# sampling is a little messed up but doesn't matter since we will have to sort by author anyways later
# samples <- make.samples(parsed_corpus, sampling = "random.sampling", sample.size = 10000)

# characters 
corpus_chars <- load.corpus.and.parse(files, corpus.dir = "", 
	markup.type = "html", sample.size = 10000, splitting.rule = '""', sampling = "no.sampling", 
	sampling.with.replacement = FALSE, features = "c", ngram.size = 1, preserve.case = TRUE)

# samples_chars <- make.samples(parsed_corpus_chars, sampling = "random.sampling", 
# 	sample.size = 100)

# english words
corpus_words <- load.corpus.and.parse(files, corpus.dir = "", 
	markup.type = "html", language = "English.all",  sample.size = 10000, 
	sampling = "no.sampling", sampling.with.replacement = FALSE, features = "w", 
	ngram.size = 1, preserve.case = TRUE)

# write to rparsed folder
for (a in 1:length(corpus_words)) {
	paste0(reu_path, rparsed_path, strsplit(files[a], ".txt")[1], "_rparsed.txt")
	write(unlist(corpus_words[a]), paste0(reu_path, rparsed_path, files[a]))
}


corpus_words_bigrams <- load.corpus.and.parse(files, corpus.dir = "", 
	markup.type = "html", language = "English.all",  sample.size = 10000, 
	sampling = "no.sampling", sampling.with.replacement = FALSE, features = "w", 
	ngram.size = 2, preserve.case = TRUE)

# write(unlist(parsed_corpus_english), file = file.path(samples_path, "test.txt"))

# samples_english <- make.samples(parsed_corpus_english, sampling = "random.sampling", 
# 	sample.size = 10000)

# write(unlist(samples_english[1]), file = file.path(samples_path, "test_english_sample_1.txt"))

# sentences.. CHECK SPLITTING RULE
corpus_sentences <- load.corpus.and.parse(files, corpus.dir = "", 
	markup.type = "html", splitting.rule = '[?.!]+[" "\n\t]', sample.size = 10000, 
	sampling = "no.sampling", sampling.with.replacement = FALSE, features = "w", 
	ngram.size = 1, preserve.case = TRUE)

# samples_sentences <- make.samples(parsed_corpus_sentences, sampling = "random.sampling", 
# 	sample.size = 3)

# head(parsed_corpus)

# words <- unlist(c(parsed_corpus))
# head(words)

##### DON'T RUN THIS... TOO MANY WORDS.. NEED TO GROUP WORDS
# make.table.of.frequencies(parsed_corpus, words, absent.sensitive = TRUE, relative = TRUE)

# make.table.of.frequencies(parsed_corpus, stylo.pronouns(), absent.sensitive = TRUE, relative = TRUE)


##### now for some classification
# classify(gui = TRUE, training.frequencies = NULL, test.frequencies = NULL, training.corpus = NULL, 
# test.corpus = NULL, features = NULL, path = NULL, training.corpus.dir = "primary_set", 
# test.corpus.dir = "secondary_set", ...)








##### ATTRIBUTES 

### general stuff  # DONE.. ish. check fully later
	num_tokens <- numeric(0)

	num_chars <- numeric(0)
	num_alpha_chars <- numeric(0)
	num_upper_chars <- numeric(0)
	num_digit_chars <- numeric(0)
	num_white_chars <- numeric(0)
	num_tab_chars <- numeric(0)
	num_lines <- numeric(0)
	num_blank_lines<- numeric(0)
	num_spaces <- numeric(0)


	num_words <- numeric(0)
	num_short_words <- numeric(0)   # less than four characters / M
	num_chars_in_words <- numeric(0)
	avg_word_length <- numeric(0)
	avg_chars_in_sentence <- numeric(0)
	avg_words_in_sentence <- numeric(0)
	unique_words <- numeric(0)
	num_unique_words <- numeric(0)

### letter freqs   # DONE
	a_freq <- numeric(0)
	b_freq <- numeric(0)
	c_freq <- numeric(0)
	d_freq <- numeric(0)
	e_freq <- numeric(0)
	f_freq <- numeric(0)
	g_freq <- numeric(0)
	h_freq <- numeric(0)
	i_freq <- numeric(0)
	j_freq <- numeric(0)
	k_freq <- numeric(0)
	l_freq <- numeric(0)
	m_freq <- numeric(0)
	n_freq <- numeric(0)
	o_freq <- numeric(0)
	p_freq <- numeric(0)
	q_freq <- numeric(0)
	r_freq <- numeric(0)
	s_freq <- numeric(0)
	t_freq <- numeric(0)
	u_freq <- numeric(0)
	v_freq <- numeric(0)
	w_freq <- numeric(0)
	x_freq <- numeric(0)
	y_freq <- numeric(0)
	z_freq <- numeric(0)  # done #DONE

### special char freqs   # DONE
	tilde_freq <- numeric(0)
	at_freq <- numeric(0)
	pound_freq <- numeric(0)
	dollar_freq <- numeric(0)
	percent_freq <- numeric(0)
	carrot_freq <- numeric(0)
	ampersand_freq <- numeric(0)
	asterisk_freq <- numeric(0)
	dash_freq <- numeric(0)
	underscore_freq <- numeric(0)
	equals_freq <- numeric(0)
	plus_freq <- numeric(0)
	greater_freq <- numeric(0)
	less_freq <- numeric(0)
	openbrace_freq <- numeric(0)
	closebrace_freq <- numeric(0)
	openbracket_freq <- numeric(0)
	closebracket_freq <- numeric(0)
	slash_freq <- numeric(0)
	backslash_freq <- numeric(0)
	or_freq <- numeric(0) #DONE

### linguistic stuff	#DONE in java 
	num_hapax_legomena <- numeric(0)
	num_hapax_dislegomena <- numeric(0)
	yule_k <- numeric(0)
	simpson_d <- numeric(0)
	brunet_w <- numeric(0)
	honore_r <- numeric(0)

	sichel_s <- numeric(0) # corney
	entropy <- numeric(0) # corney

### lengths 	#DONE in java
	length_1 <- numeric(0)
	length_2 <- numeric(0)
	length_3 <- numeric(0)
	length_4 <- numeric(0)
	length_5 <- numeric(0)
	length_6 <- numeric(0)
	length_1 <- numeric(0)
	length_1 <- numeric(0)
	length_1 <- numeric(0)
	length_10 <- numeric(0)
	length_11 <- numeric(0)
	length_12 <- numeric(0)
	length_13 <- numeric(0)
	length_14 <- numeric(0)
	length_15 <- numeric(0)
	length_16 <- numeric(0)
	length_17 <- numeric(0)
	length_18 <- numeric(0)
	length_19 <- numeric(0)
	length_20 <- numeric(0)

### punctuation 	#DONE
	period_freq <- numeric(0)
	comma_freq <- numeric(0)
	question_freq <- numeric(0)
	exclamation_freq <- numeric(0)
	semicolon_freq <- numeric(0)
	colon_freq <- numeric(0)
	apostrophe_freq <- numeric(0)
	quote_freq <- numeric(0)
# TODO: figure out why there's no parenthesis ()

### email structure
	reply_status <- numeric(0)
	greeting <- numeric(0)
	farewell <- numeric(0)
	signature <- numeric(0)
	num_attachments <- numeric(0)
	position_of_requotes <- numeric(0)

### html tags
	html_1 <- numeric(0)
	html_2 <- numeric(0)
	html_3 <- numeric(0)
	html_4 <- numeric(0)
	html_5 <- numeric(0)
	html_6 <- numeric(0)
	html_1 <- numeric(0)
	html_1 <- numeric(0)
	html_1 <- numeric(0)
	html_10 <- numeric(0)
	html_11 <- numeric(0)
	html_12 <- numeric(0)
	html_13 <- numeric(0)
	html_14 <- numeric(0)
	html_15 <- numeric(0)
	html_16 <- numeric(0)
	html_17 <- numeric(0)
	html_18 <- numeric(0)
	html_19 <- numeric(0)
	html_20 <- numeric(0)
	html_21 <- numeric(0)
	html_22 <- numeric(0)

### Gender words
	able_end <- numeric(0)
	al_end <- numeric(0)
	ful_end <- numeric(0)
	ible_end <- numeric(0)
	ic_end <- numeric(0)
	ive_end <- numeric(0)
	less_end <- numeric(0)
	ly_end <- numeric(0)
	ous_end <- numeric(0)
	num_sorry <- numeric(0)
	apolog_start <- numeric(0)

### function word freqs
	a_freq <- numeric(0)
	about_freq <- numeric(0)
	above_freq <- numeric(0)
	after_freq <- numeric(0)
	again_freq <- numeric(0)
	ago_freq <- numeric(0)
	all_freq <- numeric(0)
	almost_freq <- numeric(0)
	along_freq <- numeric(0)
	already_freq <- numeric(0)
	also_freq <- numeric(0)
	although_freq <- numeric(0)
	always_freq <- numeric(0)
	am_freq <- numeric(0)
	among_freq <- numeric(0)
	an_freq <- numeric(0)
	and_freq <- numeric(0)
	another_freq <- numeric(0)
	any_freq <- numeric(0)
	anybody_freq <- numeric(0)
	anything_freq <- numeric(0)
	anywhere_freq <- numeric(0)
	are_freq <- numeric(0)
	arent_freq <- numeric(0)
	around_freq <- numeric(0)
	as_freq <- numeric(0)
	at_freq <- numeric(0)
	back_freq <- numeric(0)
	else_freq <- numeric(0)
	be_freq <- numeric(0)
	been_freq <- numeric(0)
	before_freq <- numeric(0)
	being_freq <- numeric(0)
	below_freq <- numeric(0)
	beneath_freq <- numeric(0)
	beside_freq <- numeric(0)
	between_freq <- numeric(0)
	beyond_freq <- numeric(0)
	both_freq <- numeric(0)
	each_freq <- numeric(0)
	but_freq <- numeric(0)
	by_freq <- numeric(0)
	can_freq <- numeric(0)
	cant_freq <- numeric(0)
	could_freq <- numeric(0)
	couldnt_freq <- numeric(0)
	did_freq <- numeric(0)
	didnt_freq <- numeric(0)
	do_freq <- numeric(0)
	does_freq <- numeric(0)
	doesnt_freq <- numeric(0)
	doing_freq <- numeric(0)
	done_freq <- numeric(0)
	dont_freq <- numeric(0)
	down_freq <- numeric(0)
	during_freq <- numeric(0)
	either_freq <- numeric(0)
	enough_freq <- numeric(0)
	even_freq <- numeric(0)
	ever_freq <- numeric(0)
	every_freq <- numeric(0)
	everybody_freq <- numeric(0)
	everyone_freq <- numeric(0)
	everything_freq <- numeric(0)
	everywhere_freq <- numeric(0)
	except_freq <- numeric(0)
	far_freq <- numeric(0)
	few_freq <- numeric(0)
	fewer_freq <- numeric(0)
	first_freq <- numeric(0)
	for_freq <- numeric(0)
	from_freq <- numeric(0)
	get_freq <- numeric(0)
	gets_freq <- numeric(0)
	getting_freq <- numeric(0)
	got_freq <- numeric(0)
	had_freq <- numeric(0)
	hadnt_freq <- numeric(0)
	has_freq <- numeric(0)
	hasnt_freq <- numeric(0)
	have_freq <- numeric(0)
	havent_freq <- numeric(0)
	having_freq <- numeric(0)
	he_freq <- numeric(0)
	hed_freq <- numeric(0)
	hell_freq <- numeric(0)
	hence_freq <- numeric(0)
	her_freq <- numeric(0)
	here_freq <- numeric(0)
	hers_freq <- numeric(0)
	herself_freq <- numeric(0)
	hes_freq <- numeric(0)
	him_freq <- numeric(0)
	himself_freq <- numeric(0)
	his_freq <- numeric(0)
	hither_freq <- numeric(0)
	how_freq <- numeric(0)
	however_freq <- numeric(0)
	near_freq <- numeric(0)
	i_freq <- numeric(0)
	id_freq <- numeric(0)
	if_freq <- numeric(0)
	ill_freq <- numeric(0)
	im_freq <- numeric(0)
	in_freq <- numeric(0)
	into_freq <- numeric(0)
	is_freq <- numeric(0)
	ive_freq <- numeric(0)
	isnt_freq <- numeric(0)
	it_freq <- numeric(0)
	its_freq <- numeric(0)
	its_freq <- numeric(0)
	itself_freq <- numeric(0)
	last_freq <- numeric(0)
	less_freq <- numeric(0)
	many_freq <- numeric(0)
	me_freq <- numeric(0)
	may_freq <- numeric(0)
	might_freq <- numeric(0)
	mine_freq <- numeric(0)
	more_freq <- numeric(0)
	most_freq <- numeric(0)
	much_freq <- numeric(0)
	must_freq <- numeric(0)
	mustnt_freq <- numeric(0)
	my_freq <- numeric(0)
	myself_freq <- numeric(0)
	near_freq <- numeric(0)
	nearby_freq <- numeric(0)
	nearly_freq <- numeric(0)
	neither_freq <- numeric(0)
	never_freq <- numeric(0)
	next_freq <- numeric(0)
	no_freq <- numeric(0)
	nobody_freq <- numeric(0)
	none_freq <- numeric(0)
	noone_freq <- numeric(0)
	nothing_freq <- numeric(0)
	nor_freq <- numeric(0)
	not_freq <- numeric(0)
	now_freq <- numeric(0)
	nowhere_freq <- numeric(0)
	of_freq <- numeric(0)
	off_freq <- numeric(0)
	often_freq <- numeric(0)
	on_freq <- numeric(0)
	or_freq <- numeric(0)
	once_freq <- numeric(0)
	one_freq <- numeric(0)
	only_freq <- numeric(0)
	other_freq <- numeric(0)
	others_freq <- numeric(0)
	ought_freq <- numeric(0)
	oughtnt_freq <- numeric(0)
	our_freq <- numeric(0)
	ours_freq <- numeric(0)
	ourselves_freq <- numeric(0)
	out_freq <- numeric(0)
	over_freq <- numeric(0)
	quite_freq <- numeric(0)
	rather_freq <- numeric(0)
	round_freq <- numeric(0)
	second_freq <- numeric(0)
	shall_freq <- numeric(0)
	shant_freq <- numeric(0)
	shed_freq <- numeric(0)
	she_freq <- numeric(0)
	shell_freq <- numeric(0)
	shes_freq <- numeric(0)
	should_freq <- numeric(0)
	shouldnt_freq <- numeric(0)
	since_freq <- numeric(0)
	so_freq <- numeric(0)
	some_freq <- numeric(0)
	somebody_freq <- numeric(0)
	someone_freq <- numeric(0)
	something_freq <- numeric(0)
	sometimes_freq <- numeric(0)
	somewhere_freq <- numeric(0)
	soon_freq <- numeric(0)
	still_freq <- numeric(0)
	such_freq <- numeric(0)
	than_freq <- numeric(0)
	that_freq <- numeric(0)
	thats_freq <- numeric(0)
	the_freq <- numeric(0)
	their_freq <- numeric(0)
	theirs_freq <- numeric(0)
	them_freq <- numeric(0)
	themselves_freq <- numeric(0)
	these_freq <- numeric(0)
	then_freq <- numeric(0)
	thence_freq <- numeric(0)
	there_freq <- numeric(0)
	therefore_freq <- numeric(0)
	they_freq <- numeric(0)
	theyd_freq <- numeric(0)
	theyll_freq <- numeric(0)
	theyre_freq <- numeric(0)
	this_freq <- numeric(0)
	thither_freq <- numeric(0)
	those_freq <- numeric(0)
	though_freq <- numeric(0)
	through_freq <- numeric(0)
	thus_freq <- numeric(0)
	till_freq <- numeric(0)
	to_freq <- numeric(0)
	towards_freq <- numeric(0)
	today_freq <- numeric(0)
	tomorrow_freq <- numeric(0)
	too_freq <- numeric(0)
	under_freq <- numeric(0)
	underneath_freq <- numeric(0)
	unless_freq <- numeric(0)
	until_freq <- numeric(0)
	up_freq <- numeric(0)
	us_freq <- numeric(0)
	very_freq <- numeric(0)
	when_freq <- numeric(0)
	was_freq <- numeric(0)
	wasnt_freq <- numeric(0)
	we_freq <- numeric(0)
	wed_freq <- numeric(0)
	well_freq <- numeric(0)
	were_freq <- numeric(0)
	were_freq <- numeric(0)
	werent_freq <- numeric(0)
	weve_freq <- numeric(0)
	what_freq <- numeric(0)
	whence_freq <- numeric(0)
	where_freq <- numeric(0)
	whereas_freq <- numeric(0)
	which_freq <- numeric(0)
	while_freq <- numeric(0)
	whither_freq <- numeric(0)
	who_freq <- numeric(0)
	whom_freq <- numeric(0)
	whose_freq <- numeric(0)
	why_freq <- numeric(0)
	will_freq <- numeric(0)
	with_freq <- numeric(0)
	within_freq <- numeric(0)
	without_freq <- numeric(0)
	wont_freq <- numeric(0)
	would_freq <- numeric(0)
	wouldnt_freq <- numeric(0)
	yes_freq <- numeric(0)
	yesterday_freq <- numeric(0)
	yet_freq <- numeric(0)
	you_freq <- numeric(0)
	your_freq <- numeric(0)
	youd_freq <- numeric(0)
	youll_freq <- numeric(0)
	youre_freq <- numeric(0)
	yours_freq <- numeric(0)
	yourself_freq <- numeric(0)
	yourselves_freq <- numeric(0)
	youve_freq <- numeric(0)
	theyre_freq <- numeric(0)
	weve_freq <- numeric(0)

### word length freqs
	l_1_freq <- numeric(0)
	l_2_freq <- numeric(0)
	l_3_freq <- numeric(0)
	l_4_freq <- numeric(0)
	l_5_freq <- numeric(0)
	l_6_freq <- numeric(0)
	l_7_freq <- numeric(0)
	l_8_freq <- numeric(0)
	l_9_freq <- numeric(0)
	l_10_freq <- numeric(0)
	l_11_freq <- numeric(0)
	l_12_freq <- numeric(0)
	l_13_freq <- numeric(0)
	l_14_freq <- numeric(0)
	l_15_freq <- numeric(0)
	l_16_freq <- numeric(0)
	l_17_freq <- numeric(0)
	l_18_freq <- numeric(0)
	l_19_freq <- numeric(0)
	l_20_freq <- numeric(0)



### lists and stuff
	letters_list <- c("a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", 
		"o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z")
	special_chars <- c("~", "@", "#", "$", "%", "^", "&", "*", "-", "_", "=", "+", ">", "<", 
		"[", "]", "{", "}", "/", "\\", "|")
	function_words <- c("a", "about", "above", "after", "again", "ago", "all", "almost", 
		"along", "already", "also", "although", "always", "am", "among", "an", "and", 
		"another", "any", "anybody", "anything", "anywhere", "are", "aren't", "around", 
		"as", "at", "back", "else", "be", "been", "before", "being", "below", "beneath", 
		"beside", "between", "beyond", "both", "each", "but", "by", "can", "can't", "could", 
		"couldn't", "did", "didn't", "do", "does", "doesn't", "doing", "done", "don't", "down", 
		"during", "either", "enough", "even", "ever", "every", "everybody", "everyone", 
		"everything", "everywhere", "except", "far", "few", "fewer", "first", "for", "from", 
		"get", "gets", "getting", "got", "had", "hadn't", "has", "hasn't", "have", "haven't", 
		"having", "he", "he'd", "he'll", "hence", "her", "here", "hers", "herself", "he's", 
		"him", "himself", "his", "hither", "how", "however", "near", "i", "i'd", "if", "i'll", 
		"i'm", "in", "into", "is", "i've", "isn't", "it", "its", "it's", "itself", "last", 
		"less", "many", "me", "may", "might", "mine", "more", "most", "much", "must", "mustn't", 
		"my", "myself", "near", "nearby", "nearly", "neither", "never", "next", "no", "nobody", 
		"none", "noone", "nothing", "nor", "not", "now", "nowhere", "of", "off", "often", "on", 
		"or", "once", "one", "only", "other", "others", "ought", "oughtn't", "our", "ours", 
		"ourselves", "out", "over", "quite", "rather", "round", "second", "shall", "shan't", 
		"she'd", "she", "she'll", "she's", "should", "shouldn't", "since", "so", "some", 
		"somebody", "someone", "something", "sometimes", "somewhere", "soon", "still", "such", 
		"than", "that", "that's", "the", "their", "theirs", "them", "themselves", "these", "then",
		"thence", "there", "therefore", "they", "they'd", "they'll", "they're", "this", "thither",
		"those", "though", "through", "thus", "till", "to", "towards", "today", "tomorrow", "too", 
		"under", "underneath", "unless", "until", "up", "us", "very", "when", "was", "wasn't", "we", 
		"we'd", "we'll", "were", "we're", "weren't", "we've", "what", "whence", "where", "whereas", 
		"which", "while", "whither", "who", "whom", "whose", "why", "will", "with", "within", 
		"without", "won't", "would", "wouldn't", "yes", "yesterday", "yet", "you", "your", "you'd", 
		"you'll", "you're", "yours", "yourself", "yourselves", "you've", "they're", "we've")
	digits_list <- c("0", "1", "2", "3", "4", "5", "6", "7", "8", "9")
	punctuation_list <- c(".", ",", "?", "!", ";", ":", "'", "\"")
	whitespace_list <- c(" ", "\t", "\n") 
# TODO: figure out how to deal with function words that are contractions (often leave out ')

alpha_counter <- 0
upper_counter <- 0
digit_counter <- 0
whitespace_counter <- 0
tab_counter <- 0
hapax_dislegomena <- character(0)

# corpus_u <- unlist(corpus)
# corpus_words_u <- unlist(corpus_words)
# corpus_chars_u <- unlist(corpus_chars)
# corpus_sentences_u <- unlist(corpus_sentences)
# corpus_words_bigrams_u <- unlist(corpus_words_bigrams)
# iterate through every sample to gather stats
for (i in 1:length(corpus)) {

	corpus_u <- unlist(corpus[i])
	words_u <- unlist(corpus_words[i])
	chars_u <- unlist(corpus_chars[i])
	sentences_u <- unlist(corpus_sentences[i])
	bigrams_u <- unlist(corpus_words_bigrams[i])

	# general stuff
		num_tokens[i] <- length(corpus_u)
		m <- num_tokens[i]
		num_chars[i] <- length(chars_u)
		c <- num_chars[i]

		alpha_counter <- 0
		upper_counter <- 0
		digit_counter <- 0

		whitespace_counter <- 0
		tab_counter <- 0
		newline_counter <- 0
		newline_bool <- 0
		blank_line_counter <- 0
		space_counter <- 0

		# iterate through characters
		for (j in 1:length(chars_u)) {
			this_char <- chars_u[j]
			if (is.element(tolower(this_char), letters_list)) {
				newline_bool <- 0
				alpha_counter <- alpha_counter + 1
				if (!is.element(this_char, letters_list)) {
					upper_counter <- upper_counter + 1
				}
			} else if (is.element(this_char, digits_list)) {
				newline_bool <- 0
				digit_counter <- digit_counter + 1
			} else if (is.element(this_char, whitespace_list)) { # not sure about the newline
				whitespace_counter <- whitespace_counter + 1
				if (this_char == '\t') {
					tab_counter <- tab_counter + 1
					newline_bool <- 0
				} else if (this_char == '\n') { #XXX currently counts all newlines as spaces
					print("y")
					newline_counter <- newline_counter + 1
					if (newline_bool == 1) {
						blank_line_counter <- blank_line_counter + 1
					}
					newline_bool <- 1
				} else if (this_char == ' ') {
					space_counter <- space_counter + 1
					newline_bool <- 0
				}
			}
		}
		num_alpha_chars[i] <- alpha_counter
		num_upper_chars[i] = upper_counter
		num_digit_chars[i] <- digit_counter
		num_white_chars[i] <- whitespace_counter
		num_tab_chars[i] <- tab_counter
		num_lines[i] <- newline_counter
		num_blank_lines[i] <- blank_line_counter
		num_spaces[i] <- space_counter


		# iterate through words... maybe combine with the loop above?
		num_words[i] <- length(words_u)
		short_words_counter <- 0
		word_characters_counter <- 0

		# unique_words[i] <- unique(sort(unlist(samples_english[i])))
		this_unique_words <- unique(sort(words_u))
		num_unique_words[i] <- length(this_unique_words)

		
		num_hapax_legomena[i] <- 0
		num_hapax_dislegomena[i] <- 0

		for (k in 1:num_tokens[i]) {
			this_word <- corpus_u[k]
			this_word_chars <- unlist(strsplit(this_word, ""))
			this_word_length <- length(this_word_chars)
			word_characters_counter <- word_characters_counter + this_word_length

			if (this_word_length < 4) {
				short_words_counter <- short_words_counter + 1
			}
		}
		avg_word_length[i] <- word_characters_counter / num_tokens[i]
		## TODO: NEED TO COMPUTE UNIQUE WORDS
		## 2 tables, words->freq, and freq->words

		# iterate through sentences
		sentence_words_counter <- 0
		sentence_chars_counter <- 0
		num_sentences = length(sentences_u)

		for (m in 1:num_sentences) {
			this_sentence <- sentences_u[m]
			this_sentence_words <- cbind(strsplit(unlist(sentences_u[m]), " "))
			this_sentence_chars <- cbind(strsplit(unlist(sentences_u[m]), ""))
			sentence_words_counter = sentence_words_counter + length(unlist(this_sentence_words))
			sentence_chars_counter = sentence_chars_counter + length(unlist(this_sentence_chars))
		}
		avg_words_in_sentence[i] <- sentence_words_counter / num_sentences
		avg_chars_in_sentence[i] <- sentence_chars_counter / num_sentences

	# letter frequencies
		letter_frequencies <- make.table.of.frequencies(chars_u, letters_list, absent.sensitive = FALSE)
		a_freq[i] = letter_frequencies[1]
		b_freq[i] = letter_frequencies[2]
		c_freq[i] = letter_frequencies[3]
		d_freq[i] = letter_frequencies[4]
		e_freq[i] = letter_frequencies[5]
		f_freq[i] = letter_frequencies[6]
		g_freq[i] = letter_frequencies[7]
		h_freq[i] = letter_frequencies[8]
		i_freq[i] = letter_frequencies[9]
		j_freq[i] = letter_frequencies[10]
		k_freq[i] = letter_frequencies[11]
		l_freq[i] = letter_frequencies[12]
		m_freq[i] = letter_frequencies[13]
		n_freq[i] = letter_frequencies[14]
		o_freq[i] = letter_frequencies[15]
		p_freq[i] = letter_frequencies[16]
		q_freq[i] = letter_frequencies[17]
		r_freq[i] = letter_frequencies[18]
		s_freq[i] = letter_frequencies[19]
		t_freq[i] = letter_frequencies[20]
		u_freq[i] = letter_frequencies[21]
		v_freq[i] = letter_frequencies[22]
		w_freq[i] = letter_frequencies[23]
		x_freq[i] = letter_frequencies[24]
		y_freq[i] = letter_frequencies[25]
		z_freq[i] = letter_frequencies[26]

	# special char frequencies
		special_char_frequencies <- make.table.of.frequencies(chars_u, special_chars, 
			absent.sensitive = FALSE)
		tilde_freq[i] = special_char_frequencies[1]
		at_freq[i] = special_char_frequencies[2]
		pound_freq[i] = special_char_frequencies[3]
		dollar_freq[i] = special_char_frequencies[4]
		percent_freq[i] = special_char_frequencies[5]
		carrot_freq[i] = special_char_frequencies[6]
		ampersand_freq[i] = special_char_frequencies[7]
		asterisk_freq[i] = special_char_frequencies[8]
		dash_freq[i] = special_char_frequencies[9]
		underscore_freq[i] = special_char_frequencies[10]
		equals_freq[i] = special_char_frequencies[11]
		plus_freq[i] = special_char_frequencies[12]
		greater_freq[i] = special_char_frequencies[13]
		less_freq[i] = special_char_frequencies[14]
		openbrace_freq[i] = special_char_frequencies[15]
		closebrace_freq[i] = special_char_frequencies[16]
		openbracket_freq[i] = special_char_frequencies[17]
		closebracket_freq[i] = special_char_frequencies[18]
		slash_freq[i] = special_char_frequencies[19]
		backslash_freq[i] = special_char_frequencies[20]
		or_freq[i] = special_char_frequencies[21]

	# punctuation frequencies
		punctuation_freqs <- make.table.of.frequencies(chars_u, punctuation_list, 
			absent.sensitive = FALSE)
		period_freq[i] = punctuation_freqs[1]
		comma_freq[i] = punctuation_freqs[2]
		question_freq[i] = punctuation_freqs[3]
		exclamation_freq[i] = punctuation_freqs[4]
		semicolon_freq[i] = punctuation_freqs[5]
		colon_freq[i] = punctuation_freqs[6]
		apostrophe_freq[i] = punctuation_freqs[7]
		quote_freq[i] = punctuation_freqs[8]

	# funciton word freqs
		function_word_freqs <- make.table.of.frequencies(words_u, function_words, 
			absent.sensitive = FALSE)
}

stats_matrix <- cbind(num_tokens, num_chars, num_alpha_chars, num_upper_chars, num_digit_chars,
						num_white_chars, num_tab_chars, num_lines, num_blank_lines, num_spaces,
						num_words, num_short_words, 
						num_chars_in_words, avg_word_length, avg_chars_in_sentence,
						avg_words_in_sentence, unique_words, num_unique_words)

letter_freq_matrix <- cbind(a_freq, b_freq, c_freq, d_freq, e_freq, f_freq, g_freq, h_freq, 
	i_freq, j_freq, k_freq, l_freq, m_freq, n_freq, o_freq, p_freq, q_freq, r_freq, s_freq, 
	t_freq, u_freq, v_freq, w_freq, x_freq, y_freq, z_freq)

special_char_freq_matrix <- cbind(tilde_freq, at_freq, pound_freq, dollar_freq, percent_freq, 
	carrot_freq, ampersand_freq, asterisk_freq, dash_freq, underscore_freq, equals_freq, 
	plus_freq, greater_freq, less_freq, openbrace_freq, closebrace_freq, openbracket_freq, 
	closebracket_freq, slash_freq, backslash_freq, or_freq)

punctuation_freq_matrix <- cbind(period_freq, comma_freq, question_freq, exclamation_freq,
	semicolon_freq, colon_freq, apostrophe_freq, quote_freq)

function_word_freq_matrix <- cbind(function_word_freqs)

length_freqs_matrix <- cbind(l_1_freq, l_2_freq, l_3_freq, l_4_freq, l_5_freq, l_6_freq, l_7_freq, 
							l_8_freq, l_9_freq, l_10_freq, l_11_freq, l_12_freq, l_13_freq, 
							l_14_freq, l_15_freq, l_16_freq, l_17_freq, l_18_freq, l_19_freq, 
							l_20_freq)


data <- cbind(stats_matrix, letter_freq_matrix, special_char_freq_matrix, punctuation_freq_matrix
				)

# write.table(data, file = "C:/Users/Daway Chou-Ren/Desktop/table.csv", append = FALSE, sep = ", ")
write.csv(data, file = "C:/Users/Daway Chou-Ren/Desktop/table2.csv", append = FALSE, sep = ", ")

##### Lexical Features 
# Document-based
## Number of  blank lines/total number of lines
## Average sentence length (number of words)

# filename <- 
# "C:/Users/Daway Chou-Ren/Documents/REU/enron_parsed/english_sample_1_rel_freq_table.txt"
# parsed_file <- read.table(filename, sep = " ")
# file_freqs <- parsed_file[3]

# simpson <- simpson(c(file_freqs))
# simpson_output <- paste("simpson_d:\t", simpson)
# write(simpson_output, 
# "C:/Users/Daway Chou-Ren/Documents/REU/enron_parsed/english_sample_1_file_stats.txt", 
# append = TRUE)