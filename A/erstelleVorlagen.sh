#!/bin/bash

# Erzeuge das Verzeichnis "_templates"
mkdir -p _templates

# Erstelle mindestens 3 Dateien im "_templates" Verzeichnis
touch _templates/datei-1.txt _templates/datei-2.pdf _templates/datei-3.doc

# Erzeuge das Verzeichnis "_schulklassen"
mkdir -p _schulklassen

# Erstelle mindestens 2 Schulklassen-Dateien und fülle sie mit Namen
echo -e "Brändli Luca\nScherer Yannik\nBurren Noah\nWiederkehr Levin\nFuchs Levi\nGolamsakhi Amir\nNeuhaus Leon\nPamay Levin\nKral Tim\nNguyen Tim\nBurger David\nAlasaad Albara" > _schulklassen/M122-AP23d.txt
echo -e "Burren Samantha\nBurren Joshua\nBurren Dominik\nSanabria Rebecca\nSanabria Juan Antonio\nSanabria Jaël\nSanabria Diego\nSanabria Marino\nSanabria Luis Ramon\nKüenzi Ruth\nSanabria José\nSanabria Annika" > _Verwandtschaft.txt

# Skript ausführbar machen
chmod +x erstelleVorlagen.sh
