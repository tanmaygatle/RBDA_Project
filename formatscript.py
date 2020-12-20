finput = open("violations_per_rating_lower.txt")
foutput = open("violations_per_rating_low.csv", "w")
for line in finput:
	ls = [x.strip() for x in line.split("|")]
	print(ls[1:-1])
	foutput.write(",".join(ls[1:-1]) + "\n")