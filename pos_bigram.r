# extracts POS bigrams from POS tagged document (word [space] tag [\n])

options(warn = -1)

library("stylo")
library(tools)

args <- commandArgs(TRUE)

# fromDir <- args[1]
# existingData <- args[2]
# toDir <- args[3]
# posOutput <- args[4]

fromDir <- "posUnigrams/"
existingData <- "data/data.csv"
toDir <- "data/data.csv"
posOutput <- "posBigrams/"

reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"
wd <- paste0(reu_path, fromDir)
setwd(wd)



stripped_tags <- paste0(reu_path, fromDir)



files_to_bigram <-  list.files(path = stripped_tags, all.files = FALSE, pattern = "*.txt",
	full.names = FALSE, recursive = FALSE, ignore.case = TRUE, include.dirs = FALSE, 
	no.. = TRUE)

tag_bigrams <- load.corpus.and.parse(files_to_bigram, corpus.dir = "", 
	splitting.rule = "[[:space:]]+",
	sampling.with.replacement = FALSE, features = "w", ngram.size = 2, preserve.case = TRUE)

bigrams_list <- c("RB VB", "VB RB", "JJ NN", "NN JJ", "NNP JJ", "NNPS JJ", 
	"NNS JJ", ". VB", ". CC", ". UH", ". NN", ". JJ", ". RB", ". DT", "IN WDT", 
	"PRP WP", "TO RB", "TO VB", ". IN", "IN .", "NP PRP", "NP NNP")

rb_vb <- numeric(0) # infinitives?
vb_rb <- numeric(0) # split infinitives?
jj_nn <- numeric(0) # anastrophe
nn_jj <- numeric(0) # anastrophe
nnp_jj <- numeric(0) # anastrophe
nnps_jj <- numeric(0) # anastrophe
nns_jj <- numeric(0) # anastrophe
period_vb <- numeric(0)
period_cc <- numeric(0)
period_uh <- numeric(0)
period_nn <- numeric(0)
period_jj <- numeric(0)
period_rb <- numeric(0)
period_dt <- numeric(0)
in_wdt <- numeric(0) # that which
prp_wp<- numeric(0) # he who
to_rb <- numeric(0) # infinitives
to_vb <- numeric(0) # split infinitives
period_in <- numeric(0)
in_period <- numeric(0)
np_prp <- numeric(0)
np_nnp <- numeric(0)

for (a in 1:length(tag_bigrams)) {

	tags_u <- unlist(tag_bigrams[a])

	tag_frequencies <- make.table.of.frequencies(tags_u, bigrams_list, 
		absent.sensitive = FALSE) / 100

	# tag freqs
		rb_vb[a] <- tag_frequencies[1]
		vb_rb[a] <- tag_frequencies[2]
		jj_nn[a] <- tag_frequencies[3]
		nn_jj[a] <- tag_frequencies[4]
		nnp_jj[a] <- tag_frequencies[5]
		nnps_jj[a] <- tag_frequencies[6]
		nns_jj[a] <- tag_frequencies[7]
		period_vb[a] <- tag_frequencies[8]
		period_cc[a] <- tag_frequencies[9]
		period_uh[a] <- tag_frequencies[10]
		period_nn[a] <- tag_frequencies[11]
		period_jj[a] <- tag_frequencies[12]
		period_rb[a] <- tag_frequencies[13]
		period_dt[a] <- tag_frequencies[14]
		in_wdt[a] <- tag_frequencies[15]
		prp_wp[a] <- tag_frequencies[16]
		to_rb[a] <- tag_frequencies[17]
		to_vb[a] <- tag_frequencies[18]
		period_in[a] <- tag_frequencies[19]
		in_period[a] <- tag_frequencies[20]
		np_prp[a] <- tag_frequencies[21]
		np_nnp[a] <- tag_frequencies[22]

}

adverb_verb_swap <- rb_vb / (vb_rb + 1)
adj_noun_swap <- jj_nn / ((nn_jj + nnp_jj + nnps_jj + nns_jj) + 1)
infinitve_split <- to_rb / to_vb

bigram_freq_matrix <- cbind(adverb_verb_swap, adj_noun_swap,
	period_vb, period_cc, period_uh, period_nn, period_jj, period_rb, period_dt,
	in_wdt, prp_wp, infinitve_split, period_in, in_period, np_prp, np_nnp)

bigram_freq_matrix[is.na(bigram_freq_matrix)] <- 0

for (a in 1:length(tag_bigrams)) {
	output <- paste0(reu_path, posOutput, files_to_bigram[a])
	write(unlist(tag_bigrams[a]), output, sep = " ", append = FALSE)
}

base_files <- basename(file_path_sans_ext(files_to_bigram))
labels <- 0
for (a in 1:length(files_to_bigram)) {
	labels[a] <- substr(files_to_bigram[a], 0, 
		regexpr('_', files_to_bigram[a], fixed = TRUE)[1] - 1)
}

existing_data <- read.csv(paste0(reu_path, existingData), header = TRUE)
new_data <- cbind(existing_data, bigram_freq_matrix)

write.csv(new_data, file = paste0(reu_path, toDir), append = FALSE, sep = ", ",
	row.names = FALSE)


	