.PHONY: install all all-tess get-tess all-hunspell clean tidy
.SECONDARY:
.DELETE_ON_ERROR:

all: all-tess all-hunspell

install:
	sudo apt-get install sqlite3 wget
	sudo add-apt-repository -u -y ppa:alex-p/tesseract-ocr
	sudo apt-get update
	sudo apt-get install tesseract-ocr

TESS_MODELS := frak2021 GT4HistOCR ONB Fraktur_5000000 german_print frk Fraktur

GT4HistOCR.traineddata:
	wget -O $@ https://ub-backup.bib.uni-mannheim.de/~stweil/tesstrain/GT4HistOCR/tessdata_best/GT4HistOCR.traineddata

frak2021.traineddata:
	wget -O $@ https://ub-backup.bib.uni-mannheim.de/~stweil/tesstrain/frak2021/tessdata_best/frak2021-0.905.traineddata

Fraktur_5000000.traineddata:
	wget -O $@ https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/Fraktur_5000000/tessdata_fast/Fraktur_50000000.334_450937.traineddata

ONB.traineddata:
	wget -O $@ https://ub-backup.bib.uni-mannheim.de/~stweil/ocrd-train/data/ONB/tessdata_best/ONB_1.195_300718_989100.traineddata

german_print.traineddata:
	wget -O $@ https://ub-backup.bib.uni-mannheim.de/~stweil/tesstrain/german_print/german_print.traineddata

frk.traineddata:
	wget -O $@ https://github.com/tesseract-ocr/tessdata_fast/raw/main/frk.traineddata

Fraktur.traineddata:
	wget -O $@ https://github.com/tesseract-ocr/tessdata_fast/raw/main/script/Fraktur.traineddata

get-tess: $(TESS_MODELS:%=%.traineddata)

all-tess: $(foreach MODEL, $(TESS_MODELS), $(MODEL)_dta10.traineddata $(MODEL)_dta50.traineddata $(MODEL)_dta100.traineddata)

%_dta10.traineddata: %.traineddata dta_lexdb_10.words
	cp $< $@
	./combine_tessdata.sh $@ dta_lexdb_10.words

%_dta50.traineddata: %.traineddata dta_lexdb_50.words
	cp $< $@
	./combine_tessdata.sh $@ dta_lexdb_50.words

%_dta100.traineddata: %.traineddata dta_lexdb_100.words
	cp $< $@
	./combine_tessdata.sh $@ dta_lexdb_100.words

dta_lexdb_%.words: dta_lexdb.sqlite
	./sql2wordlist.sh $< $@ $*

dta_lexdb.sqlite:
	wget -O $@ https://www.dwds.de/dwds_static/lexdb/dta/lexdb.sqlite

all-hunspell: de-dta.dic

de-dta.dic: dta_lexdb_10.words
	wc -l < $< > $@
	# to do: combine DTA lemmatization and contemporary affixation to a historic affixation system (instead of fixed word list)
	grep -v -e '^[[:punct:]]' -e '^[[:digit:][:punct:]]*$$' $< | sort -u >> $@

clean: tidy
	-$(RM) *.words *_dta*.traineddata *.lstm-unicharset *.lstm-word-dawg

tidy:
	-$(RM)  *.lstm-unicharset *.lstm-word-dawg *.__tmp__
