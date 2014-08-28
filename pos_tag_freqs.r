options(warn = -1)

library("stylo")
library(tools)

args <- commandArgs(TRUE)

# fromDir <- args[1]
# existingData <- args[2]
# toDir <- args[3]
# posOutput <- args[4]

fromDir <- "pos_tagged/"
existingData <- "data/data.csv"
toDir <- "data/data.csv"
posOutput <- "posUnigrams/"

reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"
wd <- paste0(reu_path, fromDir)
setwd(wd)



files_dir = paste0(reu_path, fromDir)

files <- list.files(all.files = FALSE, full.names = FALSE, 
	recursive = TRUE, ignore.case = TRUE, include.dirs = FALSE, no.. = FALSE)

tags <- load.corpus.and.parse(files, corpus.dir = "", markup.type = "html", 
	 sample.size = 10000, splitting.rule = "\\s+", sampling = "no.sampling", 
	sampling.with.replacement = FALSE, features = "w", ngram.size = 1, preserve.case = TRUE)



tags_list <- c("CC", "CD", "DT", "EX", "FW", "IN", "JJ", "JJR", "JJS", "LS", "MD", "NN", "NNP",
	"NNPS", "NNS", "PDT", "POS", "PRP", "PRP$", "RB", "RBR", "RBS", "RP", "SYM", "TO", "UH",
	"VB", "VBD", "VBG", "VBN", "VBP", "VBZ", "WDT", "WP", "WP$", "WRB")

# tag_freqs
	cc_freq <- numeric(0)
	cd_freq <- numeric(0)
	dt_freq <- numeric(0)
	ex_freq <- numeric(0)
	fw_freq <- numeric(0)
	in_freq <- numeric(0)
	jj_freq <- numeric(0)
	jjr_freq <- numeric(0)
	jjs_freq <- numeric(0)
	ls_freq <- numeric(0)
	md_freq <- numeric(0)
	nn_freq <- numeric(0)
	nnp_freq <- numeric(0)
	nnps_freq <- numeric(0)
	nns_freq <- numeric(0)
	pdt_freq <- numeric(0)
	pos_freq <- numeric(0)
	prp_freq <- numeric(0)
	prp_dollar_freq <- numeric(0)
	rb_freq <- numeric(0)
	rbr_freq <- numeric(0)
	rbs_freq <- numeric(0)
	rp_freq <- numeric(0)
	sym_freq <- numeric(0)
	to_freq <- numeric(0)
	uh_freq <- numeric(0)
	vb_freq <- numeric(0)
	vbd_freq <- numeric(0)
	vbg_freq <- numeric(0)
	vbn_freq <- numeric(0)
	vbp_freq <- numeric(0)
	vbz_freq <- numeric(0)
	wdt_freq <- numeric(0)
	wp_freq <- numeric(0)
	wp_dollar_freq <- numeric(0)
	wrb_freq <- numeric(0)

for (a in 1:length(tags)) {

	tags_u <- unlist(tags[a])

	tag_frequencies <- make.table.of.frequencies(tags_u, tags_list, 
		absent.sensitive = FALSE) / 100

	# tag freqs
		cc_freq[a] <- tag_frequencies[1]
		cd_freq[a] <- tag_frequencies[2]
		dt_freq[a] <- tag_frequencies[3]
		ex_freq[a] <- tag_frequencies[4]
		fw_freq[a] <- tag_frequencies[5]
		in_freq[a] <- tag_frequencies[6]
		jj_freq[a] <- tag_frequencies[7]
		jjr_freq[a] <- tag_frequencies[8]
		jjs_freq[a] <- tag_frequencies[9]
		ls_freq[a] <- tag_frequencies[10]
		md_freq[a] <- tag_frequencies[11]
		nn_freq[a] <- tag_frequencies[12]
		nnp_freq[a] <- tag_frequencies[13]
		nnps_freq[a] <- tag_frequencies[14]
		nns_freq[a] <- tag_frequencies[15]
		pdt_freq[a] <- tag_frequencies[16]
		pos_freq[a] <- tag_frequencies[17]
		prp_freq[a] <- tag_frequencies[18]
		prp_dollar_freq[a] <- tag_frequencies[19]
		rb_freq[a] <- tag_frequencies[20]
		rbr_freq[a] <- tag_frequencies[21]
		rbs_freq[a] <- tag_frequencies[22]
		rp_freq[a] <- tag_frequencies[23]
		sym_freq[a] <- tag_frequencies[24]
		to_freq[a] <- tag_frequencies[25]
		uh_freq[a] <- tag_frequencies[26]
		vb_freq[a] <- tag_frequencies[27]
		vbd_freq[a] <- tag_frequencies[28]
		vbg_freq[a] <- tag_frequencies[29]
		vbn_freq[a] <- tag_frequencies[30]
		vbp_freq[a] <- tag_frequencies[31]
		vbz_freq[a] <- tag_frequencies[32]
		wdt_freq[a] <- tag_frequencies[33]
		wp_freq[a] <- tag_frequencies[34]
		wp_dollar_freq[a] <- tag_frequencies[35]
		wrb_freq[a] <- tag_frequencies[36]

}

tag_freq_matrix <- cbind(cc_freq, cd_freq, dt_freq, ex_freq, fw_freq, in_freq, jj_freq, 
	jjr_freq, jjs_freq, ls_freq, md_freq, nn_freq, nnp_freq, nnps_freq, nns_freq, pdt_freq, 
	pos_freq, prp_freq, prp_dollar_freq, rb_freq, rbr_freq, rbs_freq, rp_freq, sym_freq, 
	to_freq, uh_freq, vb_freq, vbd_freq, vbg_freq, vbn_freq, vbp_freq, vbz_freq, wdt_freq, 
	wp_freq, wp_dollar_freq, wrb_freq)
tag_freq_matrix[is.na(tag_freq_matrix)] <- 0

base_files <- basename(file_path_sans_ext(files))
labels <- 0
for (a in 1:length(files)) {
	labels[a] <- substr(files[a], 0, regexpr('_', files[a], fixed = TRUE)[1] - 1)
}


existing_data <- read.csv(paste0(reu_path, existingData), header = TRUE)
new_data <- cbind(existing_data, tag_freq_matrix)

write.csv(new_data, file = paste0(reu_path, toDir), append = FALSE, sep = ", ",
	row.names = FALSE)


stripped_tags <- paste0(reu_path, posOutput)

for (a in 1:length(tags)) {
	tags_only <- unlist(tags[a])[c(FALSE,TRUE)]
	output <- paste0(stripped_tags, files[a])
	write(tags_only, output, sep = " ", append = FALSE)
}


# files_to_bigram <-  list.files(path = stripped_tags, all.files = FALSE, pattern = "*.txt",
# 	full.names = TRUE, recursive = FALSE, ignore.case = TRUE, include.dirs = FALSE, 
# 	no.. = TRUE)

# tag_bigrams <- load.corpus.and.parse(files_to_bigram, corpus.dir = "", markup.type = "html", 
# language = "English.all", sample.size = 10000, sampling = "no.sampling", 
# sampling.with.replacement = FALSE, features = "w", ngram.size = 2, preserve.case = TRUE)




# # existing_data <- read.csv(paste0(reu_path, existingData), header = TRUE)
# # new_data <- cbind(existing_data, tag_freq_matrix)

# # write.csv(new_data, file = paste0(reu_path, toDir), append = FALSE, sep = ", ",
# # 	row.names = FALSE)

# 	tag_bigrams_u <- unlist(tag_bigrams)

# 	for (b in 1:length(tag_bigrams_u)) {
# 		pair <- tag_bigrams_u[b]
# 		split_pair <- strsplit(pair, ' ')
# 		joined_pair <- paste(split_pair[1], split_pair[2], sep = '|')

# 		output <- paste0(stripped_tags, files[a])

# 		if (b == 1) {
# 			write(joined_pair, output, sep = " ", append = FALSE)
# 		} else {
# 			write(joined_pair, output, sep = " ", append = TRUE)
# 		}
# 	}

	
# }