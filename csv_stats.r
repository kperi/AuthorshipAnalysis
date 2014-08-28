options(warn = -1)

reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"

args <- commandArgs(TRUE)

# fromDir <- args[1]
# toDir <- args[2]

fromDir <- "data/data.csv"
toDir <- "data/data_stats.csv"


csv <- read.csv(paste0(reu_path, fromDir), header = TRUE)
x <- file.create(paste0(reu_path, toDir))
write.csv(csv, paste0(reu_path, toDir), append = TRUE, col.names = TRUE, row.names = FALSE)

means <- numeric(0)
std_devs <- numeric(0)

for (a in 2:length(csv)) {  # start at 2 to ignore header row

	col <- csv[,a]

	means[a - 1] <- 0

	counter <- 0
	for (c in 1:length(col)) {
		# print(as.numeric(col[c]))
		# print(means[a])
		if (!is.na(col[c]) && col[c] != 0) {
			means[a - 1] <- means[a - 1] + as.numeric(col[c])
			counter <- counter + 1
		}
	}
	if (counter != 0) {
		means[a - 1] <- means[a - 1] / counter
	} else {
		means[a - 1] <- 0
	}


	# print(means[a])

	counter <- 0
	squared_diffs <- 0
	for (b in 1:length(col)) {
		
		if (is.numeric(col[b])) {
			squared_diffs <- squared_diffs + (col[b] - means[a - 1]) * (col[b] - means[a - 1])
			counter <- counter + 1
		}
	}
	
	if (length(squared_diffs) == 0 || is.na(means[a - 1]) || is.nan(means[a - 1])) {
		std_devs[a - 1] <- NA
	} else {
		std_devs[a - 1] <- sqrt(squared_diffs / (counter - 1))
	}}

means_t <- as.matrix(t(means))
std_devs_t <- as.matrix(t(std_devs))
std_devs_t[is.na(std_devs_t)] <- 0

write.table(means_t, paste0(reu_path, toDir), sep = ',', append = TRUE, col.names = FALSE,
	row.name = "mean")
write.table(std_devs_t, paste0(reu_path, toDir), sep = ',', append = TRUE, col.names = FALSE,
	row.name = "std_dev")