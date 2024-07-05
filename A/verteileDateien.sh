#!/bin/bash

# Lese alle Dateien aus dem Verzeichnis "_schulklassen"
for class_file in _schulklassen/*.txt; do
    # Extrahiere den Klassennamen (ohne .txt Endung)
    class_name=$(basename "$class_file" .txt)
    
    # Erstelle ein Verzeichnis für jede Klasse
    mkdir -p "gen/$class_name"
    
    # Schleife über jede Zeile in der Klassen-Datei (Schülernamen)
    while IFS= read -r student_name; do
        # Erstelle ein Verzeichnis für jeden Schüler im Klassenverzeichnis
        mkdir -p "gen/$class_name/$student_name"
        
        # Kopiere den Inhalt aus dem "_templates" Verzeichnis in das Schülerverzeichnis
        cp _templates/* "gen/$class_name/$student_name/"
    done < "$class_file"
done

# Skript ausführbar machen
chmod +x verteileDateien.sh
