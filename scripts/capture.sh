
#!/bin/bash
DATE=$(date +"%Y-%m-%d_%H-%M")

# Define the orange color and reset color
ORANGE='\033[0;33m'
RESET='\033[0m'

echo ""
echo -e  "${ORANGE}Taking picture....${RESET}"
echo "------------------"
fswebcam -r 1920x1080 -S 60 -D 2 -F 4 /home/pi/raspi-timelapse-cam-growzelt/photos/$DATE.jpg

echo ""
echo -e "${ORANGE}Starting Upload To Dropbox...${RESET}"
echo "------------------"
/home/pi/raspi-timelapse-cam-growzelt-growzelt/scripts/Dropbox-Uploader/dropbox_uploader.sh upload /home/pi/raspi-timelapse-cam-growzelt/photos/*.jpg /

echo ""
echo -e "${ORANGE}Deleting Photo locally....${RESET}"
rm /home/pi/raspi-timelapse-cam-growzelt/photos/*.jpg

echo ""
echo -e "${ORANGE}Done. Time Photo was taken: "$DATE
