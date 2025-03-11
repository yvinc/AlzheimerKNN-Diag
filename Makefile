index.html: dementia_classification.qmd
	quarto render dementia_classification.qmd --output index.html
	
report:
	make index.html