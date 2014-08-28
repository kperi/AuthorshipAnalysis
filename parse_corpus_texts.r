#!/bin/bash/Rscript

options(warn = -1)

library("stylo")
library(tools)


args <- commandArgs(TRUE)


reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"

samples_path <- args[1]
wd <- paste0(reu_path, samples_path)
setwd(wd)
rparsed_path <- args[2]
data_output <- args[3]


# reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"
# samples_path <- 'sampleSplit/facebookMessages'
# wd <- paste0("C:/Users/Daway Chou-Ren/Documents/REU/", samples_path)
# setwd(wd)
# rparsed_path <- 'sampleRParsed/'
# data_output <- 'data/'

ngram_size = 1
sample_size = 1

files_dir = paste0(reu_path, samples_path)

##### a vector of files from working directory
files <- list.files(all.files = FALSE, full.names = FALSE, 
	recursive = TRUE, ignore.case = TRUE, include.dirs = FALSE, no.. = FALSE)

# head(files)

corpus <- load.corpus.and.parse(files, corpus.dir = "", markup.type = "html", 
	language = "English.all", splitting.rule = "[[:space:]]+",
	sample.size = 10000, sampling = "no.sampling", sampling.with.replacement = FALSE, 
	features = "w", ngram.size = 1, preserve.case = TRUE)

# write to rparsed folder
for (a in 1:length(files)) {
	# paste0(reu_path, rparsed_path, strsplit(files[a], ".txt")[1], "_rparsed.txt")
	write(unlist(corpus[a]), paste0(reu_path, rparsed_path, basename(files[a])))
}

# characters 
corpus_chars <- load.corpus.and.parse(files, corpus.dir = "", 
	markup.type = "html", sample.size = 10000, splitting.rule = '""', sampling = "no.sampling", 
	sampling.with.replacement = FALSE, features = "c", ngram.size = 1, preserve.case = TRUE)


# english words
corpus_words <- load.corpus.and.parse(files, corpus.dir = "", 
	markup.type = "html", language = "English.all", 
	splitting.rule = "[[:space:]!?.,;:()$#/\"@%&*~{}\\]+",
	sampling = "no.sampling", sampling.with.replacement = FALSE, features = "w", 
	ngram.size = 1, preserve.case = TRUE)


# sentences.. CHECK SPLITTING RULE
corpus_sentences <- load.corpus.and.parse(files, corpus.dir = "", 
	markup.type = "html", splitting.rule = '[?.!]+[" "\n\t]+', sample.size = 10000, 
	sampling = "no.sampling", sampling.with.replacement = FALSE, features = "w", 
	ngram.size = 1, preserve.case = TRUE)




##### ATTRIBUTES 

### general stuff  # DONE.. ish. check fully later
	num_tokens <- numeric(0)

	num_chars <- numeric(0)
	num_alpha_chars <- numeric(0)
	num_upper_chars <- numeric(0)
	num_digit_chars <- numeric(0)
	num_white_chars <- numeric(0)
	num_special_chars <- numeric(0)

	num_tab_chars <- numeric(0)
	num_lines <- numeric(0)
	num_blank_lines<- numeric(0)
	num_spaces <- numeric(0)

	num_other <- numeric(0)

	num_words <- numeric(0)
	num_short_words <- numeric(0)   # less than four characters / M
	num_chars_in_words <- numeric(0)
	avg_word_length <- numeric(0)
	avg_chars_in_sentence <- numeric(0)
	avg_words_in_sentence <- numeric(0)
	unique_words <- numeric(0)
	num_unique_words <- numeric(0)

	chars_per_token <- numeric(0)
	alpha_char_freq <- numeric(0)
	uppercase_freq <- numeric(0)
	digit_char_freq <- numeric(0)
	white_char_freq <- numeric(0)
	special_char_freq <- numeric(0)
	blank_line_freq <- numeric(0)
	unique_word_freq <- numeric(0)

	all_lower <- numeric(0)
	all_upper <- numeric(0)
	first_upper <- numeric(0)
	other_cap <- numeric(0)

### whitespace freq
	space_freq <- numeric(0)
	tab_freq <- numeric(0)
	newline_freq <- numeric(0)

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

### digits freq
	freq_0 <- numeric(0)
	freq_1 <- numeric(0)
	freq_2 <- numeric(0)
	freq_3 <- numeric(0)
	freq_4 <- numeric(0)
	freq_5 <- numeric(0)
	freq_6 <- numeric(0)
	freq_7 <- numeric(0)
	freq_8 <- numeric(0)
	freq_9 <- numeric(0)

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
	next_freq <- numeric(0)
	no_freq <- numeric(0)
	nobody_freq <- numeric(0)
	none_freq <- numeric(0)
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
	upon_freq <- numeric(0)
	us_freq <- numeric(0)
	very_freq <- numeric(0)
	when_freq <- numeric(0)
	was_freq <- numeric(0)
	wasnt_freq <- numeric(0)
	we_freq <- numeric(0)
	wed_freq <- numeric(0)
	well_freq <- numeric(0)
	were_freq <- numeric(0)
	were_contraction_freq <- numeric(0)
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
	cannot_freq <- numeric(0)
	upon_freq <- numeric(0)
	really_freq <- numeric(0)
	completely_freq <- numeric(0)
	never_freq <- numeric(0)

	inside_freq <- numeric(0)
	like_freq <- numeric(0)
	said_freq <- numeric(0)
	behind_freq <- numeric(0)
	several_freq <- numeric(0)
	whoever_freq <- numeric(0)
	whomever_freq <- numeric(0)
	lots_freq <- numeric(0)
	certain_freq <- numeric(0)
	little_freq <- numeric(0)
	whenever_freq <- numeric(0)
	wherever_freq <- numeric(0)
	things_freq <- numeric(0)
##
	time_freq <- numeric(0)
	girl_freq <- numeric(0)
	day_freq <- numeric(0)
	coming_freq <- numeric(0)
	hello_freq <- numeric(0)
	jk_freq <- numeric(0)
	monday_freq <- numeric(0)
	tuesday_freq <- numeric(0)
	wednesday_freq <- numeric(0)
	thursday_freq <- numeric(0)
	friday_freq <- numeric(0)
	saturday_freq <- numeric(0)
	sunday_freq <- numeric(0)
	mon_freq <- numeric(0)
	tues_freq <- numeric(0)
	tue_freq <- numeric(0)
	wed_freq <- numeric(0)
	thurs_freq <- numeric(0)
	fri_freq <- numeric(0)
	sat_freq <- numeric(0)
	sun_freq <- numeric(0)
	soon_freq <- numeric(0)
	sure_freq <- numeric(0)
	call_freq <- numeric(0)
	wait_freq <- numeric(0)
	tonight_freq <- numeric(0)
	good_freq <- numeric(0)
	morning_freq <- numeric(0)
	night_freq <- numeric(0)
	tell_freq <- numeric(0)
	hey_freq <- numeric(0)
	sup_freq <- numeric(0)
	omg_freq <- numeric(0)
	lol_freq <- numeric(0)
	k_freq <- numeric(0)
	kk_freq <- numeric(0)
	ok_freq <- numeric(0)
	gonna_freq <- numeric(0)
	going_freq <- numeric(0)
	down_freq <- numeric(0)
	week_freq <- numeric(0)
	just_freq <- numeric(0)
	look_freq <- numeric(0)
	idk_freq <- numeric(0)
	idc_freq <- numeric(0)
	w_slash_e_freq <- numeric(0)
	love_freq <- numeric(0)
	up_freq <- numeric(0)
	cool_freq <- numeric(0)
	way_freq <- numeric(0)
	next_freq <- numeric(0)
	work_freq <- numeric(0)
	school_freq <- numeric(0)
	class_freq <- numeric(0)
	doing_freq <- numeric(0)
	late_freq <- numeric(0)
	wanna_freq <- numeric(0)
	last_freq <- numeric(0)
	help_freq <- numeric(0)
	pick_freq <- numeric(0)
	early_freq <- numeric(0)
	hear_freq <- numeric(0)
	see_freq <- numeric(0)
	weekend_freq <- numeric(0)
	looking_freq <- numeric(0)
	dunno_freq <- numeric(0)
	bring_freq <- numeric(0)
	kewl_freq <- numeric(0)
	good_freq <- numeric(0)
	bad_freq <- numeric(0)
	plan_freq <- numeric(0)
	bro_freq <- numeric(0)
	dude_freq <- numeric(0)
	wow_freq <- numeric(0)
	nvm_freq <- numeric(0)
	nevermind_freq <- numeric(0)
	mind_freq <- numeric(0)
	new_freq <- numeric(0)
	email_freq <- numeric(0)
	text_freq <- numeric(0)
	texts_freq <- numeric(0)
	message_freq <- numeric(0)
	messages_freq <- numeric(0)
	emails_freq <- numeric(0)
	guys_freq <- numeric(0)
	still_freq <- numeric(0)
	happy_freq <- numeric(0)
	sad_freq <- numeric(0)
	angry_freq <- numeric(0)
	talk_freq <- numeric(0)
	ask_freq <- numeric(0)
	family_freq <- numeric(0)
	lmao_freq <- numeric(0)
	party_freq <- numeric(0)
	whatever_freq <- numeric(0)
	ha_freq <- numeric(0)
	haha_freq <- numeric(0)
	hah_freq <- numeric(0)
	aha_freq <- numeric(0)
	hahaha_freq <- numeric(0)
	ah_freq <- numeric(0)
	oh_freq <- numeric(0)
	whoo_freq <- numeric(0)



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
		"o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", 
		"F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", 
		"W", "X", "Y", "Z")
	uppercase_list <- c("A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N",
		"O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z")
	special_chars <- c("~", "@", "#", "$", "%", "^", "&", "*", "-", "_", "=", "+", ">", "<", 
		"[", "]", "{", "}", "/", "\\", "|")
	function_words <- c("a", "about", "above", "after", "again", 
		"ago", "all", "almost", "along", "already", 
		"also", "although", "always", "am", "among", 
		"an", "and", "another", "any", "anybody", 
		"anything", "anywhere", "are", "aren\'t", "around", 
		"as", "at", "back", "else", "be", 
		"been",	"before", "being", "below", "beneath", 
		"beside", "between", "beyond", "both", "each", 
		"but", "by", "can", "can\'t", "could", 
		"couldn\'t", "did", "didn\'t", "do", "does",
		"doesn\'t", "doing", "done", "don\'t", "down", 
		"during", "either", "enough", "even", "ever", 
		"every", "everybody", "everyone", "everything", "everywhere", 
		"except", "far", "few", "fewer", "first", 
		"for", "from", "get", "gets", "getting", 
		"got", "had", "hadn\'t", "has", "hasn\'t", 
		"have", "haven\'t", "having", "he", "he\'d", 
		"he\'ll", "hence", "her", "here", "her\'s", 
		"herself", "he\'s", "him", "himself", "his", 
		"hither", "how", "however", "near", "i", 
		"i\'d", "if", "i\'ll", "i\'m", "in", 
		"into", "is", "i\'ve", "isn\'t", "it", 
		"its", "it\'s", "itself", "last", "less", 
		"many", "me", "may", "might", "mine", 
		"more", "most", "much", "must", "mustn\'t", 
		"my", "myself", "near", "nearby", "nearly", 
		"neither", "next", "no", "nobody", "none", 
		"nothing", "nor", "not", "now", "nowhere",
		"completely", "next", #142
		"of", "off", "often", "on", "or", 
		"once", "one", "only", "other", "others", 
		"ought", "oughtn\'t", "our", "ours", "ourselves", 
		"out", "over", "quite", "rather", "round", 
		"second", "shall", "shan\'t", "she\'d", "she", 
		"she\'ll", "she\'s", "should", "shouldn\'t", "since", 
		"so", "some", "somebody", "someone", "something", 
		"sometimes", "somewhere", "soon", "still", "such", 
		"than", "that", "that\'s", "the", "their", 
		"theirs", "them", "themselves", "these", "then",
		"thence", "there", "therefore", "they", "they\'d", 
		"they\'ll", "they\'re", "this", "thither", "those", #202
		"though", "through", "thus", "till", "to", 
		"towards", "today", "tomorrow", "too", "under", 
		"underneath", "unless", "until", "up", "us", 
		"very", "when", "was", "wasn\'t", "we", 
		"we\'d", "we\'ll", "were", "we\'re", "weren\'t", 
		"we\'ve", "what", "whence", "where", "whereas", 
		"which", "while", "whither", "who", "whom", 
		"whose", "why", "will", "with", "within", 
		"without", "won\'t", "would", "wouldn\'t", "yes", 
		"yesterday", "yet", "you", "your", "you\'d", #252
		"you\'ll", "you\'re", "yours", "yourself", "yourselves", 
		"you\'ve", "cannot", "upon", "really", "never",
		"inside", "like", "said", "behind", "several", 
		"whoever", "whomever", "lots", "certain", "little", 
		"whenever", "wherever", "things" , "time", "girl", "day", "coming", "hello", "jk", "monday", "tuesday", "wednesday", "thursday", "friday", "saturday", "sunday", "mon", "tues", "tue", "wed", "thurs", "fri", "sat", "sun", "soon", "sure", "call", "wait", "tonight", "good", "morning", "night", "tell", "hey", "sup", "omg", "lol", "k", "kk", "ok", "gonna", "going", "down", "week", "just", "look", "idk", "idc", "w/e", "love", "up", "cool", "way", "next", "work", "school", "class", "doing", "late", "wanna", "last", "help", "pick", "early", "hear", "see", "weekend", "looking", "dunno", "bring", "kewl", "good", "bad", "plan", "bro", "dude", "wow", "nvm", "nevermind", "mind", "new", "email", "text", "texts", "message", "messages", "emails", "guys", "still", "happy", "sad", "angry", "talk", "ask", "family", "lmao", "party", "whatever", "ha", "haha", "hah", "aha", "hahaha", "ah", "oh", "whoo")
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
other_counter <- 0


# iterate through every sample to gather stats
for (i in 1:length(corpus)) {

	corpus_u <- unlist(corpus[i])
	words_u <- gsub('\u2019', '\'', unlist(corpus_words[i]))
	chars_u <- unlist(corpus_chars[i])
	sentences_u <- unlist(corpus_sentences[i])
	# bigrams_u <- unlist(corpus_words_bigrams[i])

	# general stuff
		num_tokens[i] <- length(corpus_u)
		m <- num_tokens[i]
		num_chars[i] <- length(chars_u)
		c <- num_chars[i]

		num_alpha_chars[i] <- 0
		num_upper_chars[i] <- 0
		num_digit_chars[i] <- 0
		num_white_chars[i] <- 0
		num_special_chars[i] <- 0

		all_lower[i] <- 0
		all_upper[i] <- 0
		first_upper[i] <- 0
		other_cap[i] <- 0

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
				num_alpha_chars[i] <- num_alpha_chars[i] + 1
				if (is.element(this_char, uppercase_list)) {
					num_upper_chars <- num_upper_chars + 1
				}
			} else if (is.element(this_char, digits_list)) {
				newline_bool <- 0
				num_digit_chars <- num_digit_chars + 1
			} else if (is.element(this_char, whitespace_list)) { # not sure about the newline
				num_white_chars <- num_white_chars + 1
			} else if (is.element(this_char, special_chars)) {
				num_special_chars <- num_special_chars + 1
			}
		}

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

			if (this_word == tolower(this_word)) {
				all_lower[i] <- all_lower[i] + 1
			} else if (this_word == toupper(this_word)) {
				all_upper[i] <- all_upper[i] + 1
			} else if (is.element(substring(this_word, 0, 1), uppercase_list)) {
				first_upper[i] <- first_upper[i] + 1
			} else {
				other_cap[i] <- other_cap[i] + 1
			}

			if (this_word_length < 4) {
				short_words_counter <- short_words_counter + 1
			}
		}
		avg_word_length[i] <- word_characters_counter / num_tokens[i]

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

	# whitespace frequencies
		whitespace_frequencies <- make.table.of.frequencies(chars_u, whitespace_list, 
			absent.sensitive = FALSE) / 100
		space_freq[i] = whitespace_frequencies[1]
		tab_freq[i] = whitespace_frequencies[2]
		newline_freq[i] = whitespace_frequencies[3]

	letter_frequencies <- make.table.of.frequencies(chars_u, letters_list, 
		absent.sensitive = FALSE) / 100
	# letter frequencies
		a_freq[i] = letter_frequencies[1] + letter_frequencies[27]
		b_freq[i] = letter_frequencies[2] + letter_frequencies[28]
		c_freq[i] = letter_frequencies[3] + letter_frequencies[29]
		d_freq[i] = letter_frequencies[4] + letter_frequencies[30]
		e_freq[i] = letter_frequencies[5] + letter_frequencies[31]
		f_freq[i] = letter_frequencies[6] + letter_frequencies[32]
		g_freq[i] = letter_frequencies[7] + letter_frequencies[33]
		h_freq[i] = letter_frequencies[8] + letter_frequencies[34]
		i_freq[i] = letter_frequencies[9] + letter_frequencies[35]
		j_freq[i] = letter_frequencies[10] + letter_frequencies[36]
		k_freq[i] = letter_frequencies[11] + letter_frequencies[37]
		l_freq[i] = letter_frequencies[12] + letter_frequencies[38]
		m_freq[i] = letter_frequencies[13] + letter_frequencies[39]
		n_freq[i] = letter_frequencies[14] + letter_frequencies[40]
		o_freq[i] = letter_frequencies[15] + letter_frequencies[41]
		p_freq[i] = letter_frequencies[16] + letter_frequencies[42]
		q_freq[i] = letter_frequencies[17] + letter_frequencies[43]
		r_freq[i] = letter_frequencies[18] + letter_frequencies[44]
		s_freq[i] = letter_frequencies[19] + letter_frequencies[45]
		t_freq[i] = letter_frequencies[20] + letter_frequencies[46]
		u_freq[i] = letter_frequencies[21] + letter_frequencies[47]
		v_freq[i] = letter_frequencies[22] + letter_frequencies[48]
		w_freq[i] = letter_frequencies[23] + letter_frequencies[49]
		x_freq[i] = letter_frequencies[24] + letter_frequencies[50]
		y_freq[i] = letter_frequencies[25] + letter_frequencies[51]
		z_freq[i] = letter_frequencies[26] + letter_frequencies[52]

	digit_frequencies <- make.table.of.frequencies(chars_u, digits_list, 
		absent.sensitive = FALSE) / 100
	# digit frequencies
		freq_0[i] = digit_frequencies[1]
		freq_1[i] = digit_frequencies[2]
		freq_2[i] = digit_frequencies[3]
		freq_3[i] = digit_frequencies[4]
		freq_4[i] = digit_frequencies[5]
		freq_5[i] = digit_frequencies[6]
		freq_6[i] = digit_frequencies[7]
		freq_7[i] = digit_frequencies[8]
		freq_8[i] = digit_frequencies[9]
		freq_9[i] = digit_frequencies[10]

	special_char_frequencies <- make.table.of.frequencies(chars_u, special_chars, 
		absent.sensitive = FALSE) / 100
	# special char frequencies
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

	punctuation_freqs <- make.table.of.frequencies(chars_u, punctuation_list, 
		absent.sensitive = FALSE) / 100
	# punctuation frequencies
		period_freq[i] = punctuation_freqs[1]
		comma_freq[i] = punctuation_freqs[2] 
		question_freq[i] = punctuation_freqs[3]
		exclamation_freq[i] = punctuation_freqs[4] 
		semicolon_freq[i] = punctuation_freqs[5] 
		colon_freq[i] = punctuation_freqs[6] 
		apostrophe_freq[i] = punctuation_freqs[7] 
		quote_freq[i] = punctuation_freqs[8]

	function_word_freqs <- make.table.of.frequencies(tolower(words_u), function_words, 
			absent.sensitive = FALSE) / 100
	# function word freqs
		a_freq[i] <- function_word_freqs[1]
		about_freq[i] <- function_word_freqs[2]
		above_freq[i] <- function_word_freqs[3]
		after_freq[i] <- function_word_freqs[4]
		again_freq[i] <- function_word_freqs[5]
		ago_freq[i] <- function_word_freqs[6]
		all_freq[i] <- function_word_freqs[7]
		almost_freq[i] <- function_word_freqs[8]
		along_freq[i] <- function_word_freqs[9]
		already_freq[i] <- function_word_freqs[10]
		also_freq[i] <- function_word_freqs[11]
		although_freq[i] <- function_word_freqs[12]
		always_freq[i] <- function_word_freqs[13]
		am_freq[i] <- function_word_freqs[14]
		among_freq[i] <- function_word_freqs[15]
		an_freq[i] <- function_word_freqs[16]
		and_freq[i] <- function_word_freqs[17]
		another_freq[i] <- function_word_freqs[18]
		any_freq[i] <- function_word_freqs[19]
		anybody_freq[i] <- function_word_freqs[20]
		anything_freq[i] <- function_word_freqs[21]
		anywhere_freq[i] <- function_word_freqs[22]
		are_freq[i] <- function_word_freqs[23]
		arent_freq[i] <- function_word_freqs[24]
		around_freq[i] <- function_word_freqs[25]
		as_freq[i] <- function_word_freqs[26]
		at_freq[i] <- function_word_freqs[27]
		back_freq[i] <- function_word_freqs[28]
		else_freq[i] <- function_word_freqs[29]
		be_freq[i] <- function_word_freqs[30]
		been_freq[i] <- function_word_freqs[31]
		before_freq[i] <- function_word_freqs[32]
		being_freq[i] <- function_word_freqs[33]
		below_freq[i] <- function_word_freqs[34]
		beneath_freq[i] <- function_word_freqs[35]
		beside_freq[i] <- function_word_freqs[36]
		between_freq[i] <- function_word_freqs[37]
		beyond_freq[i] <- function_word_freqs[38]
		both_freq[i] <- function_word_freqs[39]
		each_freq[i] <- function_word_freqs[40]
		but_freq[i] <- function_word_freqs[41]
		by_freq[i] <- function_word_freqs[42]
		can_freq[i] <- function_word_freqs[43]
		cant_freq[i] <- function_word_freqs[44]
		could_freq[i] <- function_word_freqs[45]
		couldnt_freq[i] <- function_word_freqs[46]
		did_freq[i] <- function_word_freqs[47]
		didnt_freq[i] <- function_word_freqs[48]
		do_freq[i] <- function_word_freqs[49]
		does_freq[i] <- function_word_freqs[50]
		doesnt_freq[i] <- function_word_freqs[51]
		doing_freq[i] <- function_word_freqs[52]
		done_freq[i] <- function_word_freqs[53]
		dont_freq[i] <- function_word_freqs[54]
		down_freq[i] <- function_word_freqs[55]
		during_freq[i] <- function_word_freqs[56]
		either_freq[i] <- function_word_freqs[57]
		enough_freq[i] <- function_word_freqs[58]
		even_freq[i] <- function_word_freqs[59]
		ever_freq[i] <- function_word_freqs[60]
		every_freq[i] <- function_word_freqs[61]
		everybody_freq[i] <- function_word_freqs[62]
		everyone_freq[i] <- function_word_freqs[63]
		everything_freq[i] <- function_word_freqs[64]
		everywhere_freq[i] <- function_word_freqs[65]
		except_freq[i] <- function_word_freqs[66]
		far_freq[i] <- function_word_freqs[67]
		few_freq[i] <- function_word_freqs[68]
		fewer_freq[i] <- function_word_freqs[69]
		first_freq[i] <- function_word_freqs[70]
		for_freq[i] <- function_word_freqs[71]
		from_freq[i] <- function_word_freqs[72]
		get_freq[i] <- function_word_freqs[73]
		gets_freq[i] <- function_word_freqs[74]
		getting_freq[i] <- function_word_freqs[75]
		got_freq[i] <- function_word_freqs[76]
		had_freq[i] <- function_word_freqs[77]
		hadnt_freq[i] <- function_word_freqs[78]
		has_freq[i] <- function_word_freqs[79]
		hasnt_freq[i] <- function_word_freqs[80]
		have_freq[i] <- function_word_freqs[81]
		havent_freq[i] <- function_word_freqs[82]
		having_freq[i] <- function_word_freqs[83]
		he_freq[i] <- function_word_freqs[84]
		hed_freq[i] <- function_word_freqs[85]
		hell_freq[i] <- function_word_freqs[86]
		hence_freq[i] <- function_word_freqs[87]
		her_freq[i] <- function_word_freqs[88]
		here_freq[i] <- function_word_freqs[89]
		hers_freq[i] <- function_word_freqs[90]
		herself_freq[i] <- function_word_freqs[91]
		hes_freq[i] <- function_word_freqs[92]
		him_freq[i] <- function_word_freqs[93]
		himself_freq[i] <- function_word_freqs[94]
		his_freq[i] <- function_word_freqs[95]
		hither_freq[i] <- function_word_freqs[96]
		how_freq[i] <- function_word_freqs[97]
		however_freq[i] <- function_word_freqs[98]
		near_freq[i] <- function_word_freqs[99]
		i_freq[i] <- function_word_freqs[100]
		id_freq[i] <- function_word_freqs[101]
		if_freq[i] <- function_word_freqs[102]
		ill_freq[i] <- function_word_freqs[103]
		im_freq[i] <- function_word_freqs[104]
		in_freq[i] <- function_word_freqs[105]
		into_freq[i] <- function_word_freqs[106]
		is_freq[i] <- function_word_freqs[107]
		ive_freq[i] <- function_word_freqs[108]
		isnt_freq[i] <- function_word_freqs[109]
		it_freq[i] <- function_word_freqs[110]
		its_freq[i] <- function_word_freqs[111]
		its_freq[i] <- function_word_freqs[112]
		itself_freq[i] <- function_word_freqs[113]
		last_freq[i] <- function_word_freqs[114]
		less_freq[i] <- function_word_freqs[115]
		many_freq[i] <- function_word_freqs[116]
		me_freq[i] <- function_word_freqs[117]
		may_freq[i] <- function_word_freqs[118]
		might_freq[i] <- function_word_freqs[119]
		mine_freq[i] <- function_word_freqs[120]
		more_freq[i] <- function_word_freqs[121]
		most_freq[i] <- function_word_freqs[122]
		much_freq[i] <- function_word_freqs[123]
		must_freq[i] <- function_word_freqs[124]
		mustnt_freq[i] <- function_word_freqs[125]
		my_freq[i] <- function_word_freqs[126]
		myself_freq[i] <- function_word_freqs[127]
		near_freq[i] <- function_word_freqs[128]
		nearby_freq[i] <- function_word_freqs[129]
		nearly_freq[i] <- function_word_freqs[130]
		neither_freq[i] <- function_word_freqs[131]
		never_freq[i] <- function_word_freqs[132]
		no_freq[i] <- function_word_freqs[133]
		nobody_freq[i] <- function_word_freqs[134]
		none_freq[i] <- function_word_freqs[135]
		nothing_freq[i] <- function_word_freqs[136]
		nor_freq[i] <- function_word_freqs[137]
		not_freq[i] <- function_word_freqs[138]
		now_freq[i] <- function_word_freqs[139]
		nowhere_freq[i] <- function_word_freqs[140]
		completely_freq[i] <- function_word_freqs[141]
		next_freq[i] <- function_word_freqs[142]
		of_freq[i] <- function_word_freqs[143]
		off_freq[i] <- function_word_freqs[144]
		often_freq[i] <- function_word_freqs[145]
		on_freq[i] <- function_word_freqs[146]
		or_freq[i] <- function_word_freqs[147]
		once_freq[i] <- function_word_freqs[148]
		one_freq[i] <- function_word_freqs[149]
		only_freq[i] <- function_word_freqs[150]
		other_freq[i] <- function_word_freqs[151]
		others_freq[i] <- function_word_freqs[152]
		ought_freq[i] <- function_word_freqs[153]
		oughtnt_freq[i] <- function_word_freqs[154]
		our_freq[i] <- function_word_freqs[155]
		ours_freq[i] <- function_word_freqs[156]
		ourselves_freq[i] <- function_word_freqs[157]
		out_freq[i] <- function_word_freqs[158]
		over_freq[i] <- function_word_freqs[159]
		quite_freq[i] <- function_word_freqs[160]
		rather_freq[i] <- function_word_freqs[161]
		round_freq[i] <- function_word_freqs[162]
		second_freq[i] <- function_word_freqs[163]
		shall_freq[i] <- function_word_freqs[164]
		shant_freq[i] <- function_word_freqs[165]
		shed_freq[i] <- function_word_freqs[166]
		she_freq[i] <- function_word_freqs[167]
		shell_freq[i] <- function_word_freqs[168]
		shes_freq[i] <- function_word_freqs[169]
		should_freq[i] <- function_word_freqs[170]
		shouldnt_freq[i] <- function_word_freqs[171]
		since_freq[i] <- function_word_freqs[172]
		so_freq[i] <- function_word_freqs[173]
		some_freq[i] <- function_word_freqs[174]
		somebody_freq[i] <- function_word_freqs[175]
		someone_freq[i] <- function_word_freqs[176]
		something_freq[i] <- function_word_freqs[177]
		sometimes_freq[i] <- function_word_freqs[178]
		somewhere_freq[i] <- function_word_freqs[179]
		soon_freq[i] <- function_word_freqs[180]
		still_freq[i] <- function_word_freqs[181]
		such_freq[i] <- function_word_freqs[182]
		than_freq[i] <- function_word_freqs[183]
		that_freq[i] <- function_word_freqs[184]
		thats_freq[i] <- function_word_freqs[185]
		the_freq[i] <- function_word_freqs[186]
		their_freq[i] <- function_word_freqs[187]
		theirs_freq[i] <- function_word_freqs[188]
		them_freq[i] <- function_word_freqs[189]
		themselves_freq[i] <- function_word_freqs[190]
		these_freq[i] <- function_word_freqs[191]
		then_freq[i] <- function_word_freqs[192]
		thence_freq[i] <- function_word_freqs[193]
		there_freq[i] <- function_word_freqs[194]
		therefore_freq[i] <- function_word_freqs[195]
		they_freq[i] <- function_word_freqs[196]
		theyd_freq[i] <- function_word_freqs[197]
		theyll_freq[i] <- function_word_freqs[198]
		theyre_freq[i] <- function_word_freqs[199]
		this_freq[i] <- function_word_freqs[200]
		thither_freq[i] <- function_word_freqs[201]
		those_freq[i] <- function_word_freqs[202]
		though_freq[i] <- function_word_freqs[203]
		through_freq[i] <- function_word_freqs[204]
		thus_freq[i] <- function_word_freqs[205]
		till_freq[i] <- function_word_freqs[206]
		to_freq[i] <- function_word_freqs[207]
		towards_freq[i] <- function_word_freqs[208]
		today_freq[i] <- function_word_freqs[209]
		tomorrow_freq[i] <- function_word_freqs[210]
		too_freq[i] <- function_word_freqs[211]
		under_freq[i] <- function_word_freqs[212]
		underneath_freq[i] <- function_word_freqs[213]
		unless_freq[i] <- function_word_freqs[214]
		until_freq[i] <- function_word_freqs[215]
		up_freq[i] <- function_word_freqs[216]
		us_freq[i] <- function_word_freqs[217]
		very_freq[i] <- function_word_freqs[218]
		when_freq[i] <- function_word_freqs[219]
		was_freq[i] <- function_word_freqs[220]
		wasnt_freq[i] <- function_word_freqs[221]
		we_freq[i] <- function_word_freqs[222]
		wed_freq[i] <- function_word_freqs[223]
		well_freq[i] <- function_word_freqs[224]
		were_freq[i] <- function_word_freqs[225]
		were_contraction_freq[i] <- function_word_freqs[226]
		werent_freq[i] <- function_word_freqs[227]
		weve_freq[i] <- function_word_freqs[228]
		what_freq[i] <- function_word_freqs[229]
		whence_freq[i] <- function_word_freqs[230]
		where_freq[i] <- function_word_freqs[231]
		whereas_freq[i] <- function_word_freqs[232]
		which_freq[i] <- function_word_freqs[233]
		while_freq[i] <- function_word_freqs[234]
		whither_freq[i] <- function_word_freqs[235]
		who_freq[i] <- function_word_freqs[236]
		whom_freq[i] <- function_word_freqs[237]
		whose_freq[i] <- function_word_freqs[238]
		why_freq[i] <- function_word_freqs[239]
		will_freq[i] <- function_word_freqs[240]
		with_freq[i] <- function_word_freqs[241]
		within_freq[i] <- function_word_freqs[242]
		without_freq[i] <- function_word_freqs[243]
		wont_freq[i] <- function_word_freqs[244]
		would_freq[i] <- function_word_freqs[245]
		wouldnt_freq[i] <- function_word_freqs[246]
		yes_freq[i] <- function_word_freqs[247]
		yesterday_freq[i] <- function_word_freqs[248]
		yet_freq[i] <- function_word_freqs[249]
		you_freq[i] <- function_word_freqs[250]
		your_freq[i] <- function_word_freqs[251]
		youd_freq[i] <- function_word_freqs[252]
		youll_freq[i] <- function_word_freqs[253]
		youre_freq[i] <- function_word_freqs[254]
		yours_freq[i] <- function_word_freqs[255]
		yourself_freq[i] <- function_word_freqs[256]
		yourselves_freq[i] <- function_word_freqs[257]
		youve_freq[i] <- function_word_freqs[258]

		cannot_freq[i] <- function_word_freqs[259]
		upon_freq[i] <- function_word_freqs[260]
		really_freq[i] <- function_word_freqs[261]
		never_freq[i] <- function_word_freqs[262]
		inside_freq[i] <- function_word_freqs[263]
		like_freq[i] <- function_word_freqs[264]
		said_freq[i] <- function_word_freqs[265]
		behind_freq[i] <- function_word_freqs[266]
		several_freq[i] <- function_word_freqs[267]
		whoever_freq[i] <- function_word_freqs[268]
		whomever_freq[i] <- function_word_freqs[269]
		lots_freq[i] <- function_word_freqs[270]
		certain_freq[i] <- function_word_freqs[271]
		little_freq[i] <- function_word_freqs[272]
		whenever_freq[i] <- function_word_freqs[273]
		wherever_freq[i] <- function_word_freqs[274]
		things_freq[i] <- function_word_freqs[275]

	#
		time_freq[i] <- function_word_freqs[276]
		girl_freq[i] <- function_word_freqs[277]
		day_freq[i] <- function_word_freqs[278]
		coming_freq[i] <- function_word_freqs[279]
		hello_freq[i] <- function_word_freqs[280]
		jk_freq[i] <- function_word_freqs[281]
		monday_freq[i] <- function_word_freqs[282]
		tuesday_freq[i] <- function_word_freqs[283]
		wednesday_freq[i] <- function_word_freqs[284]
		thursday_freq[i] <- function_word_freqs[285]
		friday_freq[i] <- function_word_freqs[286]
		saturday_freq[i] <- function_word_freqs[287]
		sunday_freq[i] <- function_word_freqs[288]
		mon_freq[i] <- function_word_freqs[289]
		tues_freq[i] <- function_word_freqs[290]
		tue_freq[i] <- function_word_freqs[291]
		wed_freq[i] <- function_word_freqs[292]
		thurs_freq[i] <- function_word_freqs[293]
		fri_freq[i] <- function_word_freqs[294]
		sat_freq[i] <- function_word_freqs[295]
		sun_freq[i] <- function_word_freqs[296]
		soon_freq[i] <- function_word_freqs[297]
		sure_freq[i] <- function_word_freqs[298]
		call_freq[i] <- function_word_freqs[299]
		wait_freq[i] <- function_word_freqs[300]
		tonight_freq[i] <- function_word_freqs[301]
		good_freq[i] <- function_word_freqs[302]
		morning_freq[i] <- function_word_freqs[303]
		night_freq[i] <- function_word_freqs[304]
		tell_freq[i] <- function_word_freqs[305]
		hey_freq[i] <- function_word_freqs[306]
		sup_freq[i] <- function_word_freqs[307]
		omg_freq[i] <- function_word_freqs[308]
		lol_freq[i] <- function_word_freqs[309]
		k_freq[i] <- function_word_freqs[310]
		kk_freq[i] <- function_word_freqs[311]
		ok_freq[i] <- function_word_freqs[312]
		gonna_freq[i] <- function_word_freqs[313]
		going_freq[i] <- function_word_freqs[314]
		down_freq[i] <- function_word_freqs[315]
		week_freq[i] <- function_word_freqs[316]
		just_freq[i] <- function_word_freqs[317]
		look_freq[i] <- function_word_freqs[318]
		idk_freq[i] <- function_word_freqs[319]
		idc_freq[i] <- function_word_freqs[320]
		w_slash_e_freq[i] <- function_word_freqs[321]
		love_freq[i] <- function_word_freqs[323]
		up_freq[i] <- function_word_freqs[324]
		cool_freq[i] <- function_word_freqs[325]
		way_freq[i] <- function_word_freqs[326]
		next_freq[i] <- function_word_freqs[327]
		work_freq[i] <- function_word_freqs[328]
		school_freq[i] <- function_word_freqs[329]
		class_freq[i] <- function_word_freqs[330]
		doing_freq[i] <- function_word_freqs[331]
		late_freq[i] <- function_word_freqs[332]
		wanna_freq[i] <- function_word_freqs[333]
		last_freq[i] <- function_word_freqs[334]
		help_freq[i] <- function_word_freqs[335]
		pick_freq[i] <- function_word_freqs[336]
		early_freq[i] <- function_word_freqs[337]
		hear_freq[i] <- function_word_freqs[338]
		see_freq[i] <- function_word_freqs[339]
		weekend_freq[i] <- function_word_freqs[340]
		looking_freq[i] <- function_word_freqs[341]
		dunno_freq[i] <- function_word_freqs[342]
		bring_freq[i] <- function_word_freqs[343]
		kewl_freq[i] <- function_word_freqs[344]
		good_freq[i] <- function_word_freqs[345]
		bad_freq[i] <- function_word_freqs[346]
		plan_freq[i] <- function_word_freqs[347]
		bro_freq[i] <- function_word_freqs[348]
		dude_freq[i] <- function_word_freqs[349]
		wow_freq[i] <- function_word_freqs[350]
		nvm_freq[i] <- function_word_freqs[351]
		nevermind_freq[i] <- function_word_freqs[352]
		mind_freq[i] <- function_word_freqs[353]
		new_freq[i] <- function_word_freqs[354]
		email_freq[i] <- function_word_freqs[355]
		text_freq[i] <- function_word_freqs[356]
		texts_freq[i] <- function_word_freqs[357]
		message_freq[i] <- function_word_freqs[358]
		messages_freq[i] <- function_word_freqs[359]
		emails_freq[i] <- function_word_freqs[360]
		guys_freq[i] <- function_word_freqs[361]
		still_freq[i] <- function_word_freqs[362]
		happy_freq[i] <- function_word_freqs[363]
		sad_freq[i] <- function_word_freqs[364]
		angry_freq[i] <- function_word_freqs[365]
		talk_freq[i] <- function_word_freqs[366]
		ask_freq[i] <- function_word_freqs[367]
		family_freq[i] <- function_word_freqs[368]
		lmao_freq[i] <- function_word_freqs[369]
		party_freq[i] <- function_word_freqs[370]
		whatever_freq[i] <- function_word_freqs[371]
		ha_freq[i] <- function_word_freqs[372]
		haha_freq[i] <- function_word_freqs[373]
		hah_freq[i] <- function_word_freqs[374]
		aha_freq[i] <- function_word_freqs[375]
		hahaha_freq[i] <- function_word_freqs[376]
		ah_freq[i] <- function_word_freqs[377]
		oh_freq[i] <- function_word_freqs[378]
		whoo_freq[i] <- function_word_freqs[379]

	chars_per_token[i] <- num_chars[i] / num_tokens[i]
	alpha_char_freq[i] <- num_alpha_chars[i] / num_chars[i]
	uppercase_freq[i] <- num_upper_chars[i] / num_alpha_chars[i]
	digit_char_freq[i] <- num_digit_chars[i] / num_chars[i]
	white_char_freq[i] <- num_white_chars[i] / num_chars[i]
	special_char_freq[i] <- num_special_chars[i] / num_chars[i]
	blank_line_freq[i] <- num_blank_lines[i] / num_lines[i]
	unique_word_freq[i] <- num_unique_words[i] / num_words[i]
}


# stats_matrix <- cbind(chars_per_token, alpha_char_freq, uppercase_freq, 
						# digit_char_freq, white_char_freq, special_char_freq,						
						# avg_words_in_sentence, unique_word_freq)
stats_matrix <- cbind(num_tokens, chars_per_token, alpha_char_freq, uppercase_freq, 
						digit_char_freq, white_char_freq, special_char_freq, blank_line_freq,						
						avg_words_in_sentence, unique_word_freq, all_lower, all_upper, first_upper,
						other_cap)

whitespace_freq_matrix <- cbind(space_freq, tab_freq, newline_freq)
# whitespace_freq_matrix <- cbind(space_freq)

letter_freq_matrix <- cbind(a_freq, b_freq, c_freq, d_freq, e_freq, f_freq, g_freq, h_freq, 
	i_freq, j_freq, k_freq, l_freq, m_freq, n_freq, o_freq, p_freq, q_freq, r_freq, s_freq, 
	t_freq, u_freq, v_freq, w_freq, x_freq, y_freq, z_freq)

digits_freq_matrix <- cbind(freq_0, freq_1, freq_2, freq_3, freq_4, freq_5, freq_6, freq_7, 
	freq_8, freq_9)

special_char_freq_matrix <- cbind(tilde_freq, at_freq, pound_freq, dollar_freq, percent_freq, 
	carrot_freq, ampersand_freq, asterisk_freq, dash_freq, underscore_freq, equals_freq, 
	plus_freq, greater_freq, less_freq, openbrace_freq, closebrace_freq, openbracket_freq, 
	closebracket_freq, slash_freq, backslash_freq, or_freq)

punctuation_freq_matrix <- cbind(period_freq, comma_freq, question_freq, exclamation_freq,
	semicolon_freq, colon_freq, apostrophe_freq, quote_freq)

# function_word_freq_matrix <- cbind(a_freq, all_freq, also_freq, an_freq, and_freq,
	# 	any_freq, are_freq, as_freq, at_freq, be_freq, been_freq, but_freq, by_freq, 
	# 	can_freq, do_freq, down_freq, even_freq, every_freq, for_freq, from_freq, 
	# 	had_freq, has_freq, have_freq, her_freq, his_freq, if_freq, in_freq, into_freq, 
	# 	is_freq, it_freq, its_freq, may_freq, more_freq, must_freq, my_freq, no_freq, 
	# 	not_freq, now_freq, of_freq, on_freq, one_freq, only_freq, or_freq, our_freq, 
	# 	shall_freq, should_freq, so_freq, some_freq, such_freq, than_freq, that_freq, 
	# 	the_freq, their_freq, then_freq, there_freq, things_freq, this_freq, to_freq,
	# 	up_freq, upon_freq, was_freq, were_freq, what_freq, when_freq, which_freq, 
	# 	who_freq, will_freq, with_freq, would_freq, your_freq)
function_word_freq_matrix <- cbind(a_freq, about_freq, above_freq, after_freq, again_freq, 
	ago_freq, all_freq, almost_freq, along_freq, already_freq, also_freq, although_freq, 
	always_freq, am_freq, among_freq, an_freq, and_freq, another_freq, any_freq, 
	anybody_freq, anything_freq, anywhere_freq, are_freq, arent_freq, around_freq, 
	as_freq, at_freq, back_freq, else_freq, be_freq, been_freq, before_freq, 
	behind_freq, being_freq, 
	below_freq, beneath_freq, beside_freq, between_freq, beyond_freq, both_freq, each_freq,
	but_freq, by_freq, can_freq, cannot_freq, cant_freq, certain_freq,
	completely_freq, could_freq, couldnt_freq, did_freq, didnt_freq, 
	do_freq, does_freq, doesnt_freq, doing_freq, done_freq, dont_freq, down_freq, 
	during_freq, either_freq, enough_freq, even_freq, ever_freq, every_freq, everybody_freq, 
	everyone_freq, everything_freq, everywhere_freq, except_freq, far_freq, few_freq, 
	fewer_freq, first_freq, for_freq, from_freq, get_freq, gets_freq, getting_freq, 
	got_freq, had_freq, hadnt_freq, has_freq, hasnt_freq, have_freq, havent_freq, 
	having_freq, he_freq, hed_freq, hell_freq, hence_freq, her_freq, here_freq, 
	hers_freq, herself_freq, hes_freq, him_freq, himself_freq, his_freq, hither_freq, 
	how_freq, however_freq, near_freq, i_freq, id_freq, if_freq, ill_freq, im_freq, 
	in_freq, inside_freq,
	into_freq, is_freq, ive_freq, isnt_freq, it_freq, its_freq, its_freq, 
	itself_freq, last_freq, less_freq, little_freq, lots_freq,
	many_freq, me_freq, may_freq, might_freq, 
	mine_freq, more_freq, most_freq, much_freq, must_freq, mustnt_freq, my_freq, 
	myself_freq, near_freq, nearby_freq, nearly_freq, neither_freq, never_freq, 
	next_freq, no_freq, nobody_freq, none_freq, nothing_freq, nor_freq, 
	not_freq, now_freq, nowhere_freq, of_freq, off_freq, often_freq, on_freq, or_freq, 
	once_freq, one_freq, only_freq, other_freq, others_freq, ought_freq, oughtnt_freq, 
	our_freq, ours_freq, ourselves_freq, out_freq, over_freq, quite_freq, rather_freq, 
	really_freq, round_freq, said_freq, second_freq, several_freq, shall_freq, 
	shant_freq, shed_freq, she_freq, shell_freq, 
	shes_freq, should_freq, shouldnt_freq, since_freq, so_freq, some_freq, somebody_freq, 
	someone_freq, something_freq, sometimes_freq, somewhere_freq, soon_freq, still_freq, 
	such_freq, than_freq, that_freq, thats_freq, the_freq, their_freq, theirs_freq, 
	them_freq, themselves_freq, these_freq, then_freq, thence_freq, there_freq, 
	therefore_freq, they_freq, theyd_freq, theyll_freq, theyre_freq, things_freq,
	this_freq, 
	thither_freq, those_freq, though_freq, through_freq, thus_freq, till_freq, to_freq, 
	towards_freq, today_freq, tomorrow_freq, too_freq, under_freq, underneath_freq, 
	unless_freq, until_freq, up_freq, upon_freq, us_freq, very_freq, when_freq, 
	was_freq, wasnt_freq, we_freq, wed_freq, well_freq, were_freq, 
	were_contraction_freq, werent_freq, weve_freq, what_freq, when_freq,
	whence_freq, whenever_freq, where_freq, wherever_freq,
	whereas_freq, which_freq, while_freq, whither_freq, who_freq, 
	whoever_freq, whom_freq, whomever_freq, 
	whose_freq, why_freq, will_freq, with_freq, within_freq, without_freq, 
	wont_freq, would_freq, wouldnt_freq, yes_freq, yesterday_freq, yet_freq, you_freq, 
	your_freq, youd_freq, youll_freq, youre_freq, yours_freq, yourself_freq, 
	yourselves_freq, youve_freq,
	time_freq, girl_freq, day_freq, coming_freq, hello_freq, jk_freq, monday_freq, tuesday_freq, wednesday_freq, thursday_freq, friday_freq, saturday_freq, sunday_freq, mon_freq, tues_freq, tue_freq, wed_freq, thurs_freq, fri_freq, sat_freq, sun_freq, soon_freq, sure_freq, call_freq, wait_freq, tonight_freq, good_freq, morning_freq, night_freq, tell_freq, hey_freq, sup_freq, omg_freq, lol_freq, k_freq, kk_freq, ok_freq, gonna_freq, going_freq, down_freq, week_freq, just_freq, look_freq, idk_freq, idc_freq, w_slash_e_freq, love_freq, up_freq, cool_freq, way_freq, next_freq, work_freq, school_freq, class_freq, doing_freq, late_freq, wanna_freq, last_freq, help_freq, pick_freq, early_freq, hear_freq, see_freq, weekend_freq, looking_freq, dunno_freq, bring_freq, kewl_freq, good_freq, bad_freq, plan_freq, bro_freq, dude_freq, wow_freq, nvm_freq, nevermind_freq, mind_freq, new_freq, email_freq, text_freq, texts_freq, message_freq, messages_freq, emails_freq, guys_freq, still_freq, happy_freq, sad_freq, angry_freq, talk_freq, ask_freq, family_freq, lmao_freq, party_freq, whatever_freq, ha_freq, haha_freq, hah_freq, aha_freq, hahaha_freq, ah_freq, oh_freq, whoo_freq)


# length_freqs_matrix <- cbind(l_1_freq, l_2_freq, l_3_freq, l_4_freq, l_5_freq, l_6_freq, l_7_freq, 
# 							l_8_freq, l_9_freq, l_10_freq, l_11_freq, l_12_freq, l_13_freq, 
# 							l_14_freq, l_15_freq, l_16_freq, l_17_freq, l_18_freq, l_19_freq, 
# 							l_20_freq)


base_files <- basename(file_path_sans_ext(files))
labels <- 0
for (a in 1:length(files)) {
	# labels[a] <- substr(files[a], 0, regexpr('/', files[a], fixed = TRUE)[1] - 1)
	labels[a] <- files[a]
}
# data <- cbind(labels, stats_matrix, punctuation_freq_matrix, function_word_freq_matrix)
# data <- cbind(labels, chars_per_token, unique_word_freq, function_word_freq_matrix)

stuff <- cbind(chars_per_token, unique_word_freq, all_lower, all_upper, first_upper, other_cap)
data <- cbind(labels, stuff, function_word_freq_matrix)

# data <- cbind(labels, stats_matrix, whitespace_freq_matrix, letter_freq_matrix, digits_freq_matrix,
# 	special_char_freq_matrix, punctuation_freq_matrix, function_word_freq_matrix)
data[is.na(data)] <- 0

# write.table(data, file = "C:/Users/Daway Chou-Ren/Desktop/table.csv", append = FALSE, sep = ", ")
write.csv(data, file = paste0(reu_path, data_output, "data.csv"), append = FALSE, sep = ", ",
	row.names = FALSE)
