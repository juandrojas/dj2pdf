#!/bin/bash
function dj2pdf() {
  FILE=$1
  OUTPUT=$2
  djvu2pdf $FILE
  echo "${FILE%%.*}.pdf"
  mv "${FILE%%.*}.pdf" test.pdf
  djvused "${FILE}" -e 'print-outline' > bmarks.out
  pdftk test.pdf dump_data > pdfmetadata.out
  python bmarkDjvu2pdf.py
  sed '/^NumberOfPages: / r bmarks.txt' pdfmetadata.out > pdfmetadata.in
  pdftk test.pdf update_info "pdfmetadata.in" output "${OUTPUT}"
  rm test.pdf
  rm pdfmetadata.in
  rm pdfmetadata.out
  rm bmarks.out
  rm bmarks.txt
}
