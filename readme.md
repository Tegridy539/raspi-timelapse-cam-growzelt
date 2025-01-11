# Raspberry Pi Timelapse Cam - Growzelt
<img src="https://github.com/user-attachments/assets/01d78771-4916-4122-bd52-99a72310e68a" alt="timelapse" width="50%" hight="50%">

## Worum geht es?
Die Idee ist, in regelmäßigen Abständen (1x die Stunde, immer um viertel nach) ein Foto von den Pflanzen zu machen, um daraus später einen Zeitraffer zu schneiden. 
Damit die Fotos auf dem Schnitt-PC einfach zugreifbar sind, werden sie direkt vom Raspberry Pi in die Dropbox hochgeladen. 
Für den Zeitraffer wird später am Schnitt-PC Davinci Resolve genutzt.

Zusätzlich erlaubt die Handy-App [Raspcontroller](https://play.google.com/store/apps/details?id=it.Ettore.raspcontroller&hl=de&pli=1) für iOS und Android, von der Couch aus den Livestream der Zeltcam zu streamen. 

## Technische Umsetzung
### Hardware
- **Raspberry Pi Model 3B+**
- Standardbenutzer: `pi`
- USB-Webcam (mit Kabelbindern befestigt)

### Software
Das Script `capture.sh` nimmt 1x die Stunde (über einen Cronjob anpassbar) ein Foto auf, lädt es in die Dropbox hoch und löscht es anschließend, um Speicherplatz auf der SD-Karte zu sparen. 
Für den Upload wird das Tool [Dropbox-Uploader](https://github.com/andreafabrizi/Dropbox-Uploader) von `andreafabrizi` genutzt, ein einfacher CLI-basierter Dropbox-Uploader.

## Schritt-für-Schritt Anleitung

#### 1. SSH-Verbindung zum Raspberry Pi herstellen
```bash
ssh pi@<Raspi-IP>
```

#### 2. Raspberry Pi aktualisieren
```bash
sudo apt-get update && sudo apt-get upgrade
```

#### 3. Automatischen Login für den Benutzer `pi` aktivieren
```bash
sudo raspi-config
```
Im Menü folgende Optionen wählen:
1. `System Options`
2. `S5 Boot/Auto Login`
3. `B2 Console Auto Login`

#### 4. Benötigte Pakete installieren
```bash
sudo apt install fswebcam
```

#### 5. Repository klonen
```bash
cd /home/pi
git clone https://github.com/Tegridy539/Raspi-Timelapse-Cam.git
```

#### 6. Dateien ausführbar machen
```bash
sudo chmod +x /home/pi/Raspi-Timelapse-Cam/scripts/Dropbox-Uploader/dropbox_uploader.sh
sudo chmod +x /home/pi/Raspi-Timelapse-Cam/scripts/capture.sh
```

#### 7. Dropbox-Uploader konfigurieren
Der Uploader muss vor der ersten Nutzung mit deiner persönlichen Dropbox über einen API-Key verbunden werden. Führe das Setup einmal aus:
```bash
/home/pi/Raspi-Timelapse-Cam/scripts/Dropbox-Uploader/dropbox_uploader.sh
```
Die Fotos werden dann in den Ordner `/Apps/<NAME_DER_DROPBOX_APP>` hochgeladen.

#### 8. Cronjob anlegen
Damit das Script `capture.sh` automatisch ausgeführt wird, öffne die Cronjob-Konfiguration:
```bash
crontab -e
```
Füge unten folgende Zeilen hinzu (die Zeitangaben können angepasst werden):
```bash
# Fotos zwischen 18:00 und 12:00 Uhr aufnehmen
15 18-23 * * * /home/pi/Raspi-Timelapse-Cam/scripts/capture.sh >/dev/null 2>&1
15 0-12 * * * /home/pi/Raspi-Timelapse-Cam/scripts/capture.sh >/dev/null 2>&1
```

### Fertig!
Das war's! Viel Spaß mit deinem Timelapse-Projekt! 😊

## Nützliche Ressourcen
- [Fswebcam Tutorial](https://www.youtube.com/watch?v=_uVaZalaSbI&t=338s)
- [Dropbox-Uploader von andreafabrizi](https://github.com/andreafabrizi/Dropbox-Uploader)
- [TIMELAPSE from static IMAGES | Davinci Resolve Tutorial](https://www.youtube.com/watch?v=SIPmp-9i_K8)
---
Readme.md erstellt mit Hilfe von **ChatGPT** 💖
