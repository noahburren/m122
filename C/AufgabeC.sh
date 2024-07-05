#!/bin/bash

# Setzt den Pfad zum Ausgabeordner für die Briefe
output_ordner="./brf"

# Setzt die aktuelle Zeit und das Datum
current_date=$(date +"%Y-%m-%d_%H-%M")

# Liest die CSV-Datei in ein Array ein, überspringt die erste Zeile
IFS=$'\r\n' GLOBIGNORE='*' command eval 'data=($(tail -n +2 mock_data.csv | cut -d "," -f 2,3))'

# Erstellt den Ausgabeordner, falls er nicht existiert
mkdir -p "$output_ordner"

# Erstellt die Ausgabedatei
outfile="${output_ordner}/${current_date}_mailimports.csv"
echo "id,email,initialpassword" > "$outfile"

# Schleife durch jede Zeile des Arrays
id=1
declare -A email_count
for line in "${data[@]}"; do
    # Extrahiert Vorname und Nachname und kombiniert sie
    name=$(echo "$line" | cut -d ',' -f 1,2 | tr ',' ' ' | iconv -f utf-8 -t ascii//TRANSLIT//IGNORE)
    name=$(echo "$name" | sed 's/ *$//')
    if [[ ! "$name" =~ ^[[:space:]]*$ ]]; then
        # Nimmt nur das erste Wort des Nachnamens und kombiniert es mit dem Vornamen
        first_name=$(echo "$name" | awk '{print $1}')
        last_name=$(echo "$name" | awk '{print $NF}')
        name="$first_name.$last_name"
        # Entfernt Leerzeichen aus der E-Mail
        email="${name,,}@edu.tbz.ch"
        email="${email// /}"
        # Überprüft auf doppelte E-Mails und fügt eine fortlaufende Nummer hinzu
        if [[ ${email_count["$email"]} ]]; then
            email_count["$email"]=$((email_count["$email"] + 1))
            email_without_domain="${email%@*}"
            email_domain="${email#*@}"
            email="${email_without_domain}_${email_count["$email"]}@${email_domain}"
        else
            email_count["$email"]=1
        fi
        # Generiert ein zufälliges Passwort
        password=$(openssl rand -base64 8 | tr -dc '[:alnum:][:punct:]' | tr -d '/+=')
        # Schreibt E-Mail und Passwort in die Ausgabedatei
        echo "$id,$email,$password" >> "$outfile"
        id=$((id+1))
    fi
done

# Kombiniert die beiden CSV-Dateien basierend auf der ID
combined_data=$(join -t, -1 1 -2 1 -o 1.1,1.2,1.3,1.4,1.5,1.6,1.7,1.8,2.2,2.3 <(sort -t, -k1,1 mock_data.csv) <(sort -t, -k1,1 "$outfile"))

# Durchsucht die kombinierten Daten und erstellt für jede Zeile einen Brief
echo "$combined_data" | while IFS=, read -r id vorname nachname geschl strasse strnummer plz ort email passwort; do
    if [[ "$id" != "id" ]]; then
        brief_datei="${output_ordner}/${current_date}_${email}.brf"
        if [[ "$geschl" == "Male" || "$geschl" == "male" ]]; then
            anrede="Lieber"
        else
            anrede="Liebe"
        fi
        cat > "$brief_datei" <<- EOM
Technische Berufsschule Zürich
Ausstellungsstrasse 70
8005 Zürich

Zürich, den $(date +"%d.%m.%Y")



            $vorname $nachname
            $strasse $strnummer
            $plz $ort


$anrede $vorname

Es freut uns, Sie im neuen Schuljahr begrüssen zu dürfen.

Damit Sie am ersten Tag sich in unsere Systeme einloggen
können, erhalten Sie hier Ihre neue Emailadresse und Ihr
Initialpasswort, das Sie beim ersten Login wechseln müssen.

Emailadresse:   $email
Passwort:       $passwort


Mit freundlichen Grüssen

Noah Burren
(TBZ-IT-Service)


admin.it@tbz.ch, Abt. IT: +41 44 446 96 60
EOM
    fi
done

# Sendet die ersten beiden brf-Dateien an den Drucker, falls vorhanden
if command -v lp &> /dev/null; then
    first_brf=$(ls "${output_ordner}"/*.brf | head -n 1)
    second_brf=$(ls "${output_ordner}"/*.brf | head -n 2 | tail -n 1)

    # Druckt die ersten beiden brf-Dateien mit dem Befehl lp
    lp "$first_brf"
    lp "$second_brf"

    # Informiert den Benutzer, dass die Dateien an den Drucker gesendet wurden
    echo "The first two brf files have been sent to the printer:"
    echo "1. $first_brf"
    echo "2. $second_brf"
else
    echo "No printer command (lp) found. Skipping printing."
fi

# Erstellt ein Archiv aus dem Ordner mit den Briefen
archive_datei="${current_date}_newMails_[AP22b_Haradini].tar.gz"
tar -czvf "$archive_datei" "$output_ordner"

# Verschiebt den Ordner mit den Briefen, um ihn zu archivieren
mv "$output_ordner" "${output_ordner}_${current_date}"
