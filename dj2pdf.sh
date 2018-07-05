FILE=$1
OUTPUT=$2
djvu2pdf $FILE
echo "${FILE%%.*}.pdf"
djvused "${FILE}" -e 'print-outline' > bmarks.out
pdftk "${FILE%%.*}.pdf" dump_data > pdfmetadata.out
python bmarkDjvu2pdf.py
sed '/^NumberOfPages: / r bmarks.txt' pdfmetadata.out > pdfmetadata.in
pdftk "${FILE%%.*}.pdf" update_info "pdfmetadata.in" output "${OUTPUT}"
rm pdfmetadata.in
rm pdfmetadata.out
rm bmarks.out
rm bmarks.txt
