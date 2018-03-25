COMPILER=latexmk
NAME=report

all: $(NAME).tex
	$(COMPILER) -pdf -pdflatex="pdflatex -shell-escape -enable-write18" \
		-use-make -auxdir=auxFiles -outdir=auxFiles $(NAME).tex ;
	cp auxFiles/*.pdf ./

pvc: $(NAME).tex
	latexmk -pvc -pdf -pdflatex="pdflatex -shell-escape -enable-write18" \
		-use-make -auxdir=auxFiles -outdir=auxFiles $(NAME).tex ;
	cp auxFiles/*.pdf ./
	
show: $(NAME).pdf
	make all;
	open $(NAME).pdf

clean:
	rm -rf ./auxFiles
