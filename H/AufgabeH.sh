#!/bin/bash

# Konfigurationsdatei
CONFIG_FILE="config.txt"
LOG_FILE="install.log"

# Log Funktion
log() {
    echo "$(date +'%Y-%m-%d %H:%M:%S') - $1" | tee -a $LOG_FILE
}

# Lese Konfigurationsdatei
if [ -f "$CONFIG_FILE" ]; then
    source $CONFIG_FILE
else
    log "Konfigurationsdatei $CONFIG_FILE nicht gefunden."
    exit 1
fi

# Installiere Tools
install_tool() {
    TOOL=$1
    PACKAGE_NAME=$2
    if ! command -v $TOOL &> /dev/null; then
        log "Installing $PACKAGE_NAME..."
        if sudo apt-get install -y $PACKAGE_NAME; then
            log "$PACKAGE_NAME installation successful."
        else
            log "$PACKAGE_NAME installation failed."
            exit 1
        fi
    else
        log "$PACKAGE_NAME is already installed."
    fi
}

log "Installation gestartet."

install_tool "curl" "curl"
install_tool "jq" "jq"
install_tool "bc" "bc"

log "Alle Tools installiert."

# Tests
run_tests() {
    TOOL=$1
    TEST_CMD=$2
    if $TEST_CMD; then
        log "$TOOL test passed."
    else
        log "$TOOL test failed."
    fi
}

log "Tests gestartet."

run_tests "curl" "curl --version"
run_tests "jq" "jq --version"
run_tests "bc" "echo '1+1' | bc"

log "Tests abgeschlossen."

# Zeige Ergebnisse auf dem Bildschirm
cat $LOG_FILE

log "Installation und Tests abgeschlossen."
