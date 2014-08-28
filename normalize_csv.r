options(warn = -1)

reu_path <- "C:/Users/Daway Chou-Ren/Documents/REU/"

args <- commandArgs(TRUE)

fromDir <- args[1]
toDir <- args[2]

fromDir <- "data/data_stats.csv"
toDir <- "normalized/facebookMessages/"

outputDir <- paste0(reu_path, toDir)
dir.create(outputDir)
all <- paste0(outputDir, 'all.csv')
known <- paste0(outputDir, 'known.csv')
unknown <- paste0(outputDir, 'unknown.csv')


csv <- read.csv(paste0(reu_path, fromDir), header = TRUE)
x <- file.create(all)
y <- file.create(known)
z <- file.create(unknown)


header <- csv[0,]
write.table(header, known, sep = ',', append = TRUE, col.names = TRUE,
	row.names = FALSE)
write.table(header, unknown, sep = ',', append = TRUE, col.names = TRUE,
	row.names = FALSE)
write.table(header, all, sep = ',', append = TRUE, col.names = TRUE,
	row.names = FALSE)

###########################
### function calculates the z-score of a value from mean and std_dev of feature
###########################
z_score <- function(mean, std_dev, value) {
	# print(value)
	# print(mean)

	if (is.na(mean) || is.na(value)) {
		z_score <- NA
	} else if (is.infinite(mean) || is.infinite(value)) {
		z_score <- Inf
	} else if ((value - mean) == 0) {  # important for when std_dev is also 0 or undefined
		z_score <- 0
	} else if (std_dev == 0 || is.na(std_dev) || is.nan(std_dev)) {
		z_score <- NaN
	} else {
		z_score <- (value - mean) / std_dev
	}

	## -1, 0, 1 trinary bins for z-scores
	# if (z_score > 0.5) {
	# 	z_score <- 1
	# } else if (z_score <- -0.5) {
	# 	z_score <- -1
	# } else {
	# 	z_score <- 0
	# }

	# print(z_score)

	return(z_score)
}
##########################

mean <- 0
std_dev <- 0
value <- 0

num_rows <- nrow(csv)

test_files_bool <- 0
label_counter <- 0
label <- ""
new_label <- ""

for (a in 1: (num_rows - 2)) {  # start at 2 to ignore header row, -2 to ignore mean/std_dev rows

	new_row <- 0
	row <- csv[a,]
	# print(head(unlist(row)))
	# print(num_rows)

	row_length <- length(row)

	for (b in 2: row_length) {
		mean <- csv[num_rows - 1, b]
		std_dev <- csv[num_rows, b]
		value <- csv[a, b]

		new_value <- z_score(mean, std_dev, value)

		new_row[b - 1] <- new_value 

	}

	new_row_t <- as.matrix(t(new_row))

	row_title <- csv[a,1]


	# if unknown is in the label, switch testfilesbool to true
	# XXX this is kind of messy, just throw outer if around write.table later
	if (length(grep("unknown", row_title, ignore.case = TRUE, value = FALSE)) != 0) {
		test_files_bool <- 1
	}

	
	# split between testing and training files
	if (!test_files_bool) {  # still in training files

		new_label <- substr(row_title, 0, regexpr('/', row_title, fixed = TRUE)[1] - 1)
		if (new_label != label) {
			label <- new_label
			label_counter <- label_counter + 1
		}

		write.table(new_row_t, known , sep = ',', append = TRUE, 
			col.names = FALSE, row.name = new_label)
		write.table(new_row_t, all, sep = ',', append = TRUE, 
			col.names = FALSE, row.name = row_title)

	} else {
		# print("in else")
		
		write.table(new_row_t, unknown, sep = ',', append = TRUE, 
			col.names = FALSE, row.name = row_title)
		# weight more so model can train to distinguish unknown features
		iterations <- (num_rows-2) %/% label_counter
		for (c in 0: 2) {
			write.table(new_row_t, all, sep = ',', append = TRUE, 
				col.names = FALSE, row.name = row_title)
		}
	}

	test_files_bool <- 0
	
}	