#!/bin/bash
# this script is for fetching names from 1099 tax PDFs and making them the file name.

# to install pdftotext on Mac do `brew install poppler`
# else you can do `sudo apt-get install poppler-utils` on linux

FILES=~/pdfs/*
for f in $FILES
do
  echo "Processing $f file..."
  # take action on each file. $f store current file name
  touch temp.txt
  pdftotext $f temp.txt
  file_name=$(grep '& country' temp.txt -A 2 | grep -o '[^try]*$' | sed "s/ /_/g") # edit this based on your needs
  file_name=${file_name//$'\n'/}
  echo "var value is: ${file_name}"
  ext=".pdf"
  cp $f ~/pdf-output/"$file_name$ext"
  rm temp.txt
done

# NOTE: To split up large PDFs into individual files check out pdftk
# you need to do something like `pdftk your_file.pdf burst output your_directory/page_%02d.pdf`
# pdftk seems to only be available for linux but I may be wrong
