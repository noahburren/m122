#!/bin/bash


mkdir -p ./_templates


touch ./_templates/datei-1.txt
touch ./_templates/datei-2.pdf
touch ./_templates/datei-3.doc

mkdir -p ./_schulklassen

schueler_namenTBZ=("Noah-Burren" "Yannik-Scherer" "Albara-Alasad" "Levi-Fuchs" "Amir-Gholamsakhi" "Levin-Wiederkehr" "Luca-Braendli" "Tim-Fischer" "Tim-Nguyen" "Chris-Evans" "Tim-Krahl" "David-Burger")
schueler_namenSekundarstufe=("Noah-Burren" "Yannik-Scherer" "Menkre-Carmen" "Merhawi-Beurert" "Thomas-Lehmann" "Cedric-Oberholzer" "Sven-Spuehler" "Yan-Bider" "Clyde-Sincalire" "Matheo-Schreiner" "Leon-Scherter" "Felix-Neumann")
schueler_namenAusbildungszentrum=("Noah-Burren" "Luca-Braendli" "Aldin-Sahinovic" "Eduard-Bulach" "Jaken-Norton" "Benjamin-Beres" "Rafael-Bert" "Michael-Graf" "Patrick-Kramer" "Erna-Salhivic" "Sara-Bamberger" "Sara-Haltic")

echo "${schueler_namenTBZ[@]}" | tr ' ' '\n' > ./_schulklassen/M122-AP23d.txt
echo "${schueler_namenSekundarstufe[@]}" | tr ' ' '\n' > ./_schulklassen/AB3b.txt
echo "${schueler_namenAusbildungszentrum[@]}" | tr ' ' '\n' > ./_schulklassen/RAU.txt

echo "Verzeichnisse und Dateien wurden erfolgreich erstellt."