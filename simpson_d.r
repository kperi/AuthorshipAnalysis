options(warn = -1)

library("stylo")
library("tools")
library("untb")

args <- commandArgs(TRUE)

reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"

fromDir <- args[1]
filename <- args[2]
toDir <- args[3]

basename_no_ext <- basename(file_path_sans_ext(filename))

fromFile <- paste0(reu_path, fromDir, basename_no_ext, '_rel_freq_table.txt')
parsed_file <- read.table(fromFile, sep = " ")
file_freqs <- parsed_file[3]

simpson <- round(simpson(c(file_freqs)), digits = 4)
simpson_output <- paste("simpson_d:\t", simpson)

write(simpson_output, paste0(reu_path, toDir, basename_no_ext, '_file_stats.txt'), append = TRUE)