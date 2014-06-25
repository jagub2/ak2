program1:
	Program ma za zadanie dzialac jako `echo`, przy starcie nalezy wpisac tekst, jednak ma ograniczenie pod tytulem dlugosc
	(jezeli dobrze licze, to 37 znakow).
	Gdy wpisze sie za dlugi tekst, to zostanie uciety, nie bedzie znaku nowej linii 
	ORAZ jego dalsza czesc pozostanie potraktowana jako komenda (gdy np. pracujemy w bashu), 
	w innych przypadkach bedzie to wygladac tak:

		user@host $ ./program
		Tekst
		Wpisales:
		Tekst
		user@host $

	Za dlugi tekst:

		user@host $ ./program
		TutajTrzebaCosWpisacAbyUstalicDlugoscwhoami
		Wpisales:
		TutajTrzebaCosWpisacAbyUstalicDlugoscuser@host $ whoami
		user
		user@host $

