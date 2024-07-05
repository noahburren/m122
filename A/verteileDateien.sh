#!/bin/bash


SCHULKLASSEN_DIR="./_schulklassen"
TEMPLATES_DIR="./_templates"

for schulklasse_file in "$SCHULKLASSEN_DIR"/*.txt; do

  klasse_name=$(basename "$schulklasse_file" .txt)

  mkdir -p "$SCHULKLASSEN_DIR/$klasse_name"

  while IFS= read -r schueler_name; do

    schueler_dir="$SCHULKLASSEN_DIR/$klasse_name/$schueler_name"
    mkdir -p "$schueler_dir"

    cp -r "$TEMPLATES_DIR/"* "$schueler_dir/"
  done < "$schulklasse_file"
done

echo "Dateien und Verzeichnisse wurden erfolgreich verteilt."