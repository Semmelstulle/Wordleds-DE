#!/bin/zsh

# URL of the remote file
url="https://raw.githubusercontent.com/davidak/wortliste/master/wortliste.txt"

# Name of the file we put the scraped words in
output_file="wortliste.txt"

# Download file
curl $url -o $output_file

# Create the file with the cleared up list
processed_file="wordleList.txt"
#> $processed_file # empties the file if neccessary
echo "wordleList.txt erstellt bzw geleert"

# Check every line of the downloaded list
while IFS= read -r line; do
  # Replace Ä, Ö, Ü and ß
  modified_line=$(echo $line | sed -e 's/Ä/ae/g' -e 's/Ö/oe/g' -e 's/Ü/ue/g' -e 's/ä/ae/g' -e 's/ö/oe/g' -e 's/ü/ue/g' -e 's/ß/ss/g')
  echo "$line modifiziert"
  # Check that modified word again
  for word in $modified_line; do
    # Check it it contains exactly 5 letters
    if [ ${#word} -eq 5 ]; then
      # Write to wordleList.txt
      echo $word >> $processed_file
      echo "$word in wordleList.txt geschrieben"
    fi
  done
done < $output_file

echo "Verarbeitung abgeschlossen. Die Wörter mit 5 Buchstaben sind in $processed_file gespeichert."
