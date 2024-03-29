# dta-lexdb-applications

[![CD](https://github.com/bertsky/dta-lexdb-applications/actions/workflows/makefile.yml/badge.svg)](https://github.com/bertsky/dta-lexdb-applications/actions/workflows/makefile.yml)

> formatting and integrating the Deutches Textarchiv dictionary into various applications

[Deutsches Textarchiv](https://www.deutsches-textarchiv.de) (DTA) is a large collection of curated and manually corrected
reference corpora in New High German from the 17th to 20th century.

[LexDB](https://www.dwds.de/r/lexdb) are a collection of lexical databases (i.e. dictionaries) distilled from DTA
by the BBAW. They include the full-form, lemmatization, normalized orthography and part-of-speech.

This repository provides scripts to extract and re-format dictionaries for re-use in other applications.
The results will be available as Github release assets.

## Tesseract OCR models with added language model

[Tesseract](https://tesseract-ocr.github.io/) models (both the originally provided ones, trained on
synthetic data, and the community generated ones, finetuned on annotated scan data or trained from scratch)
can be amended with a simple language model by providing dictionaries/grammars for punctuation, numbers and words.

We will pick publicly available models for German Antiqua and Fraktur prints, as well as handwriting,
and republish them with DTA as language model.

For currently selected models, see https://github.com/bertsky/dta-lexdb-applications/blob/83e5d5c3404da3b14886fe5eeed044ee1f630bdd/Makefile#L13-L34

## Hunspell

[Hunspell](http://hunspell.github.io/) is a widely used dictionary based, morphology aware spell checker.

We will produce a DTA dictionary for it.

For currently selected rules, see https://github.com/bertsky/dta-lexdb-applications/blob/83e5d5c3404da3b14886fe5eeed044ee1f630bdd/Makefile#L60-L63

## ...

Others to come. Please raise an issue if you have ideas!
