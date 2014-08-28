options(warn = -1)

reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"

args <- commandArgs(TRUE)

# fromDir <- args[1]
# toDir <- args[2]

fromDir <- "data/data_stats.csv"
toDir <- "data/data_stats.csv"

csv <- read.csv(paste0(reu_path, fromDir), header = TRUE)
x <- file.create(paste0(reu_path, toDir))

drops <- ""

for (a in 2:length(csv)) {

	col <- csv[,a]

	length <- length(col)

	# get mean 
	if (col[length - 1] == 0) {
		# print(paste0("add to drops ", colnames(csv[a])))
		drops <- c(drops, colnames(csv[a]))
	}  
}

csv <- csv[,!(names(csv) %in% drops)]
print(paste0("Removed ", length(drops), " columns"))



















write.csv(csv, paste0(reu_path, toDir), append = TRUE, col.names = TRUE, row.names = FALSE)