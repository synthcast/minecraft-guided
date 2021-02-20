#!/bin/bash

yes | sudo apt install openjdk-8-jre-headless screen
echo ""; echo "Available base versions from 1.9 through 1.15, and current latest version 1.16.5"

custom () {
echo "Download finished!"
read -p "The minimum amount of ram the server should use: " Xms
read -p "The maximum amount of ram the server should use: " Xmx
touch run.sh
printf "#!/bin/sh\n\njava -Xms$Xms -Xmx$Xmx -jar minecraft_server.$VER.jar nogui" >> run.sh
chmod +x ./run.sh
echo ""; echo "Start script created"
./run.sh
sed -i 's/false/true/g' eula.txt
sed -i 's/online-mode=true/online-mode=false/g' server.properties
./run.sh
}

#Available Versions
default () {
while true
do
read -p "Which version would you like to download: " VER
case $VER in
        1.16.5) wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar -O minecraft_server.1.16.5.jar; break;;
        1.15) wget https://launcher.mojang.com/v1/objects/332b3382108e5bdb0b23717082c9b97c54ffc8ad/server.jar -O minecraft_server.1.15.jar; break;;
        1.14) wget https://launcher.mojang.com/v1/objects/f1a0073671057f01aa843443fef34330281333ce/server.jar -O minecraft_server.1.14.jar; break;;
        1.13) wget https://launcher.mojang.com/v1/objects/d0caafb8438ebd206f99930cfaecfa6c9a13dca0/server.jar -O minecraft_server.1.13.jar; break;;     
        1.12) wget https://launcher.mojang.com/v1/objects/8494e844e911ea0d63878f64da9dcc21f53a3463/server.jar -O minecraft_server.1.12.jar; break;;
        1.11) wget https://launcher.mojang.com/v1/objects/48820c84cb1ed502cb5b2fe23b8153d5e4fa61c0/server.jar -O minecraft_server.1.11.jar; break;;     
        1.10) wget https://launcher.mojang.com/v1/objects/a96617ffdf5dabbb718ab11a9a68e50545fc5bee/server.jar -O minecraft_server.1.10.jar; break;;
        1.9) wget https://launcher.mojang.com/v1/objects/b4d449cf2918e0f3bd8aa18954b916a4d1880f0d/server.jar -O minecraft_server.1.9.jar; break;;
        *) echo "That version is not available, please enter a different version";;
esac
done
custom
}

while true
do
read -p "Would you like to download by custom link? [Y/n] "  CUSTOM
case $CUSTOM in
        n|N) default; break;;
        y|Y) read -p "Paste download link: " LINK; read -p "Which version is this?: " VER; wget "$LINK"; mv server.jar minecraft_server.$VER.jar; custom; break;;
        *) echo "Please enter y/n";;
esac
done

