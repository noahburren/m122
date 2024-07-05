#!/bin/bash

# Funktion zum Anzeigen der Systeminformationen in einer Tabelle
show_info() {
    printf '%-45s %s\n' "Hostname:" "$(uname -n)"
    printf '%-45s %s\n' "Betriebssystemversion:" "$(uname -srm)"
    printf '%-45s %s\n' "Anzahl der CPU-Cores:" "$(nproc)"
    printf '%-45s %s\n' "Modellname der CPU:" "$(lscpu | grep 'Model name' | sed -r 's/^.*: +//')"
    printf '%-45s %s\n' "Gesamter und genutzter Arbeitsspeicher:" "$(free -h | grep Mem | awk '{print $2 " / " $3}')"
    printf '%-46s %s\n' "Verfügbarer Speicher:" "$(df -h --total | grep total | awk '{print $4}')"
    printf '%-45s %s\n' "Freier Speicher:" "$(df -h --total | grep total | awk '{print $5}')"
    printf '%-47s %s\n' "Gesamtgröße des Dateisystems:" "$(df -h --total | grep total | awk '{print $2}')"
    printf '%-45s %s\n' "Belegter Speicher auf dem Dateisystem:" "$(df -h --total | grep total | awk '{print $3}')"
    printf '%-45s %s\n' "Freier Speicher auf dem Dateisystem:" "$(df -h --total | grep total | awk '{print $4}')"
    printf '%-45s %s\n' "Aktuelle Systemlaufzeit:" "$(uptime -p)"
    printf '%-45s %s\n' "Aktuelle Systemzeit:" "$(date)"
}

# Überprüfen, ob die Option -f angegeben wurde
if [ "$1" == "-f" ]; then
    timestamp=$(date '+%Y-%m-%d_%H%M')
    hostname=$(uname -n)
    filename="${timestamp}-sys-${hostname}.log"

    # Informationen sowohl auf dem Terminal als auch in eine Datei anzeigen
    show_info | tee "$filename"
else
    # Informationen nur auf dem Terminal anzeigen
    show_info
fi
