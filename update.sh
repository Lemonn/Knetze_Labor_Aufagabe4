#!/bin/bash
# Skript zum Updaten der Labboraufgabenkonfiguration


wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "Beginne Update"
    wget --no-check-certificate --content-disposition https://github.com/Lemonn/Knetze_Labor_Aufagabe4/blob/master/Aufgabe4-1.py
    if [ $? -eq 0 ]; then
    
    else
        echo "Fehler ggf. keine Schreibrechte, die Mininet Konfigurationen können manuell von https://github.com/Lemonn/Knetze_Labor_Aufagabe4 Heruntergeldaen werden!"
        exit
else
    echo "Keine Internetverbindung, die Mininet Konfigurationen können manuell von https://github.com/Lemonn/Knetze_Labor_Aufagabe4 Heruntergeldaen werden!"
fi
