#!/bin/bash

# API Endpoint für Wechselkurse von USD
API_URL="https://api.exchangerate-api.com/v4/latest/USD"

# Temporäre Datei für die API-Antwort
TEMP_FILE="/tmp/exchange_rates.json"

# API-Aufruf und Speichern der Antwort in einer temporären Datei
curl -s "$API_URL" > "$TEMP_FILE"

# Parse JSON und extrahiere die Wechselkurse (EUR und CHF)
EUR_RATE=$(jq -r '.rates.EUR' "$TEMP_FILE")
CHF_RATE=$(jq -r '.rates.CHF' "$TEMP_FILE")

# HTML-Datei erstellen
HTML_FILE="index.html"

# HTML-Struktur
cat << EOF > "$HTML_FILE"
<!DOCTYPE html>
<html>
<head>
  <title>Exchange Rates</title>
  <style>
    table {
      border-collapse: collapse;
      width: 50%;
      margin: auto;
    }
    th, td {
      border: 1px solid black;
      padding: 8px;
      text-align: left;
    }
  </style>
</head>
<body>
  <h2>Exchange Rates</h2>
  <table>
    <tr>
      <th>Währung</th>
      <th>Kurs zu USD</th>
    </tr>
    <tr>
      <td>EUR</td>
      <td>$EUR_RATE</td>
    </tr>
    <tr>
      <td>CHF</td>
      <td>$CHF_RATE</td>
    </tr>
  </table>
</body>
</html>
EOF

