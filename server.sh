#!/bin/bash

yes | sudo apt install openjdk-16-jre-headless screen
printf "\nAvailable base versions from 1.8 through 1.15, version 1.16.5, and current latest version 1.17\n"

custom () {
printf "Download finished!\n"
while true
do
read -p "The minimum amount of ram the server should use: " Xms
read -p "The maximum amount of ram the server should use: " Xmx
if [[ $Xms != *"M"* ]] || [[ $Xmx != *"M"* ]]; then
	printf "\nPlease specify minimum and maximum amount of ram in megabytes by adding 'M' to the end of the value\n"
	continue;
else
break;
fi
done
PARAM="java -Xms$Xms -Xmx$Xmx -jar minecraft_server.$VER.jar nogui"
touch run.sh
printf "#!/bin/sh\n\n$PARAM" >> run.sh
chmod +x ./run.sh
printf "\nStart script created\n"
version-check
}

version-check () {
if [[ $VER == 1.8 ]]; then
	$PARAM & PID=$!; sleep 10
	kill $PID; server
else
	./run.sh; server
fi
}

server () {
printf "online-mode=false" >> server.properties
sed -i 's/false/true/g' eula.txt
./run.sh
}

#Available Versions
default () {
while true
do
read -p "Which version would you like to download: " VER
case $VER in
        1.17) wget https://launcher.mojang.com/v1/objects/0a269b5f2c5b93b1712d0f5dc43b6182b9ab254e/server.jar -O minecraft_server.1.17.jar; break;;
        1.16.5) wget https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar -O minecraft_server.1.16.5.jar; break;;
	1.15) wget https://launcher.mojang.com/v1/objects/e9f105b3c5c7e85c7b445249a93362a22f62442d/server.jar -O minecraft_server.1.15.jar; break;;
	1.14) wget https://launcher.mojang.com/v1/objects/f1a0073671057f01aa843443fef34330281333ce/server.jar -O minecraft_server.1.14.jar; break;;
        1.13) wget https://launcher.mojang.com/v1/objects/d0caafb8438ebd206f99930cfaecfa6c9a13dca0/server.jar -O minecraft_server.1.13.jar; break;;
        1.12) wget https://launcher.mojang.com/v1/objects/8494e844e911ea0d63878f64da9dcc21f53a3463/server.jar -O minecraft_server.1.12.jar; break;;
        1.11) wget https://launcher.mojang.com/v1/objects/48820c84cb1ed502cb5b2fe23b8153d5e4fa61c0/server.jar -O minecraft_server.1.11.jar; break;;
        1.10) wget https://launcher.mojang.com/v1/objects/a96617ffdf5dabbb718ab11a9a68e50545fc5bee/server.jar -O minecraft_server.1.10.jar; break;;
        1.9) wget https://launcher.mojang.com/v1/objects/b4d449cf2918e0f3bd8aa18954b916a4d1880f0d/server.jar -O minecraft_server.1.9.jar; break;;
        1.8) wget https://launcher.mojang.com/v1/objects/a028f00e678ee5c6aef0e29656dca091b5df11c7/server.jar -O minecraft_server.1.8.jar; break;;
        *) printf "\nThat version is not available, please enter a different version\n";;
esac
done
custom
}

while true
do
read -p "Would you like to download by custom link? [Y/n] "  CUSTOM
case $CUSTOM in
        n|N) default; break;;
        y|Y) read -p "Please paste download link: " LINK; read -p "Which version is this?: " VER; wget "$LINK"; mv server.jar minecraft_server.$VER.jar; custom; break;;
        *) printf "\nPlease enter y/n\n";;
esac
done
