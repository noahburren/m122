#!/bin/bash

# Erstellen einer HTML-Datei mit Systeminformationen
output_file="system_info.html"

# Systeminformationen erfassen
hostname="$(uname -n)"
os_version="$(uname -srm)"
cpu_cores="$(nproc)"
cpu_model="$(lscpu | grep 'Model name' | sed -r 's/^.*: +//')"
memory_usage="$(free -h | grep Mem | awk '{print $2 " / " $3}')"
available_space="$(df -h --total | grep total | awk '{print $4}')"
free_space_percentage="$(df -h --total | grep total | awk '{print $5}')"
total_fs_size="$(df -h --total | grep total | awk '{print $2}')"
used_fs_space="$(df -h --total | grep total | awk '{print $3}')"
free_fs_space="$(df -h --total | grep total | awk '{print $4}')"
system_uptime="$(uptime -p)"
current_time="$(date)"

# Ampel-Darstellung Logik basierend auf freiem Speicher
free_space_color="red"
message="Problemanfällig"
if [[ ${free_space_percentage%?} -lt 80 ]]; then
  free_space_color="yellow"
  message="O.K."
fi
if [[ ${free_space_percentage%?} -lt 40 ]]; then
  free_space_color="green"
  message="Ordungsgemäss"
fi

# HTML-Datei erstellen
cat <<EOT > "$output_file"
<!DOCTYPE html>
<html lang="de">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Systeminformationen</title>
    <style>
        table {
            width: 70%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
        th {
            background-color: #f2f2f2;
        }
        .indicator {
            width: 20px;
            height: 20px;
            border-radius: 50%;
            display: inline-block;
        }
    </style>
</head>
<body>
    <h1>Systeminformationen</h1>
    <table>
        <tr>
            <th>Hostname</th>
            <td>$hostname</td>
        </tr>
        <tr>
            <th>Betriebssystemversion</th>
            <td>$os_version</td>
        </tr>
        <tr>
            <th>Anzahl der CPU-Cores</th>
            <td>$cpu_cores</td>
        </tr>
        <tr>
            <th>Modellname der CPU</th>
            <td>$cpu_model</td>
        </tr>
        <tr>
            <th>Gesamter und genutzter Arbeitsspeicher</th>
            <td>$memory_usage</td>
        </tr>
        <tr>
            <th>Verfügbarer Speicher</th>
            <td>$available_space</td>
        </tr>
        <tr>
            <th>Freier Speicher (%)</th>
            <td>$free_space_percentage</td>
        </tr>
        <tr>
            <th>Gesamtgröße des Dateisystems</th>
            <td>$total_fs_size</td>
        </tr>
        <tr>
            <th>Belegter Speicher auf dem Dateisystem</th>
            <td>$used_fs_space</td>
        </tr>
        <tr>
            <th>Freier Speicher auf dem Dateisystem</th>
            <td>$free_fs_space</td>
        </tr>
        <tr>
            <th>Aktuelle Systemlaufzeit</th>
            <td>$system_uptime</td>
        </tr>
        <tr>
            <th>Aktuelle Systemzeit</th>
            <td>$current_time</td>
        </tr>
    </table>
    <p style="background-color: $free_space_color;" class="indicator"></p>
    <p>Ampelanzeige: $message</p>
</body>
</html>
EOT
