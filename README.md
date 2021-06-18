# Minecraft server
### A script that sets up a dedicated vanilla Minecraft server.

# Features:
* Links to official server files so that you can download your desired version by just specifying it. 
* Available base versions from 1.8 through 1.15, version 1.16.5 and current latest version 1.17.
* Support for downloading server files with custom links.

# Usage:
Execute the script by typing `./server.sh`, then either choose to download one of the available versions, or a custom version by pasting in its download link. After that enter the minimum and maximum amount of RAM that the server should use (in megabytes), and you're done. The script will execute the `.jar` file which will generate the eula. After that it will agree to the eula, and restart the server. 

### Tips & notes:
* When downloading custom server files, there is a chance that some specific versions might not work very well with the script. For this reason, and for ease of use the script includes links to official server files from Mojang's website (even though they aren't actually listed there). For example the 1.8 version, doesn't stop after running the `.jar` file for the first time, so the script includes a simple workaround for this, by manually killing the process and continuing normally after that.  
* If you wish to stop the server just type in `stop` an hit enter, and when you want to start it again, simply execute the run script by typing in `./run.sh`.
