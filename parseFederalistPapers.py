reu_path = "C:/Users/Daway Chou-Ren/Documents/REU/"
federalistPapers = "C:/Users/Daway Chou-Ren/Documents/REU/federalistPapers.txt"

filename = open(federalistPapers + sys.argv[1], 'r')
hamilton = open(reu_path + "federalistPapers/hamilton.txt", 'w')
madison = open(reu_path + "federalistPapers/madison.txt", 'w')
jay = open(reu_path + "federalistPapers/jay.txt", 'w')

for line in filename:
	if line == "HAMILTON\n"