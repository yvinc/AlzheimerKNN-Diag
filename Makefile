.PHONY: report clean
index.html: reports/alzheimer-knn-class-report.qmd
	quarto render reports/alzheimer-knn-class-report.qmd
	mv reports/alzheimer-knn-class-report.html docs/index.html

report:
	make index.html

clean:
	rm -f docs/*.html
