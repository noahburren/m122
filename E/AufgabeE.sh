#!/bin/bash

kombinierte_csv="kombinierte_input.csv"
echo "RefNr,Betrag,Name,Strasse,PLZ,Ort,Land,IBAN" > $kombinierte_csv
for data_datei in *.data; do
    refnr=$(grep -oP '(?<=Rechnung_)[^;]+' "$data_datei")
    betrag=$(grep -oP '(?<=RechnPos;1;[^;]+;[^;]+;)[^;]+' "$data_datei")
    name=$(grep -oP '(?<=Endkunde;)[^;]+;[^;]+;[^;]+;[^;]+;[^;]+' "$data_datei")
    iban=$(grep -oP '(?<=Herkunft;)[^;]+' "$data_datei")
    echo "${refnr},${betrag},${name},${iban}" >> $kombinierte_csv
done

ftp_server="ftp.haraldmueller.ch"
ftp_benutzer="schoolerinvoices"
ftp_passwort="Berufsschule8005!"
ftp_pfad="/out/AP22bKos"

ftp -n $ftp_server <<END_SCRIPT
quote USER $ftp_benutzer
quote PASS $ftp_passwort
cd $ftp_pfad
put qr_rechnungen.zip
quit
END_SCRIPT

echo "QR-Rechnungen erfolgreich hochgeladen."
