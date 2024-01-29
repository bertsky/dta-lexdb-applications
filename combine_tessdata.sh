#!/bin/sh

combine_tessdata -e $1 ${1%.traineddata}.lstm-unicharset
wordlist2dawg $2 ${1%.traineddata}.lstm-word-dawg ${1%.traineddata}.lstm-unicharset
combine_tessdata -o $1 ${1%.traineddata}.lstm-word-dawg
