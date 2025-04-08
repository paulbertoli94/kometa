#!/bin/bash

# Genera /config/config.yml usando le variabili d'ambiente a runtime
envsubst < config.yml.tpl > /config/config.yml

# (Opzionale) Visualizza il file generato per debug
echo "Generated config.yml:"
cat /config/config.yml

# Avvia l'API (trigger.py), che potrà eseguire il comando per avviare Kometa
exec python3 trigger.py