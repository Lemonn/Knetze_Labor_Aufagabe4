#!/bin/bash
# Skript zum Updaten der Labboraufgabenkonfiguration
# Funktioniert nur mir Internet innerhalb der VM!
# Notfalls die Dateien von Hand auf dem Host herunterladen und in die VM kopieren.
wget -q --spider http://google.com

if [ $? -eq 0 ]; then
    echo "Online"
    sleep 1
    # Neue Konfuguration laden
    wget -P ~/update --no-check-certificate --content-disposition https://raw.githubusercontent.com/Lemonn/Knetze_Labor_Aufagabe4/master/Aufgabe4-1.py
    wget -P ~/update --no-check-certificate --content-disposition https://raw.githubusercontent.com/Lemonn/Knetze_Labor_Aufagabe4/master/Aufgabe4-2.py
    wget -P ~/update --no-check-certificate --content-disposition https://raw.githubusercontent.com/Lemonn/Knetze_Labor_Aufagabe4/master/Aufgabe4-3.py

    # Alte Konfiguration Löschen
    cd ~/mininet/custom/
    rm Aufgabe4-1.py Aufgabe4-2.py Aufgabe4-3.py
    mv ~/update/Aufgabe4-1.py ~/mininet/custom/
    mv ~/update/Aufgabe4-2.py ~/mininet/custom/
    mv ~/update/Aufgabe4-3.py ~/mininet/custom/
else
    echo "Keine Internetverbindung! \n"
    echo "die Mininet Konfigurationen können manuell von https://github.com/Lemonn/Knetze_Labor_Aufagabe4 Heruntergeldaen werden! \n"
    echo "Dann die drei ensprechenden Dateien in ~/mininet/custom ersetzen"
    exit 1
fi

# Befehl zum Updaten in der VM
# rm ~/update && wget -P ~/update --no-check-certificate --content-disposition https://raw.githubusercontent.com/Lemonn/Knetze_Labor_Aufagabe4/master/update.sh && chmod +x ~/update/update.sh && ~/update/update.sh
