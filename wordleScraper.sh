#!/bin/zsh

# URL der Datei, die geladen werden soll
url="https://raw.githubusercontent.com/davidak/wortliste/master/wortliste.txt"

# Name der Datei, in die der Inhalt gespeichert werden soll
output_file="wortliste.txt"

# Lade die Datei herunter
#curl $url -o $output_file

# Erstelle eine neue Datei für die bearbeiteten Wörter
processed_file="wordleList.txt"
#> $processed_file # Leert die Datei, falls sie bereits existiert
echo "wordleList.txt erstellt bzw geleert"

# Durchlaufe jede Zeile der heruntergeladenen Datei
while IFS= read -r line; do
  # Ersetze Ä, Ö, Ü und ß
  modified_line=$(echo $line | sed -e 's/Ä/ae/g' -e 's/Ö/oe/g' -e 's/Ü/ue/g' -e 's/ä/ae/g' -e 's/ö/oe/g' -e 's/ü/ue/g' -e 's/ß/ss/g')
  echo "$line modifiziert"
  # Durchlaufe jedes Wort in der Zeile
  for word in $modified_line; do
    # Check, ob das Wort genau 5 Buchstaben hat
    if [ ${#word} -eq 5 ]; then
      # Schreibe das Wort in die Datei wordleList.txt
      echo $word >> $processed_file
      echo "$word in wordleList.txt geschrieben"
    fi
  done
done < $output_file

echo "Verarbeitung abgeschlossen. Die Wörter mit 5 Buchstaben sind in $processed_file gespeichert."
