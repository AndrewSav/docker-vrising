#!/bin/bash
s=/mnt/vrising/server
p=/mnt/vrising/persistentdata
d=/mnt/vrising/persistentdata/dotnet
echo " "
echo "Downloading and installing .NET SDK 6.0.300 and core runtime..."
echo " "
mkdir "$d" 2>&1
chmod -R 777 "$d" 2>&1
cd /tmp
rm -R /tmp/*
if [ ! -f "$d/dotnet" ]; then
	### ARM ###
	#wget https://download.visualstudio.microsoft.com/download/pr/2a6f82fe-0ae8-4867-9664-c8d012301a9a/496da28497b7c7f62151e9837eb5db6f/dotnet-sdk-6.0.300-linux-musl-arm64.tar.gz
	#wget https://download.visualstudio.microsoft.com/download/pr/8ba7087e-4513-41e5-8359-a4bcd2a3661f/e6828f0d8cf1ecc63074c9ff57685e27/aspnetcore-runtime-6.0.5-linux-arm64.tar.gz
	### x64 ###
	wget https://download.visualstudio.microsoft.com/download/pr/dc930bff-ef3d-4f6f-8799-6eb60390f5b4/1efee2a8ea0180c94aff8f15eb3af981/dotnet-sdk-6.0.300-linux-x64.tar.gz
	wget https://download.visualstudio.microsoft.com/download/pr/a0e9ceb8-04eb-4510-876c-795a6a123dda/6141e57558eddc2d4629c7c14c2c6fa1/aspnetcore-runtime-6.0.5-linux-x64.tar.gz

	### ARM ###
	#tar zxf dotnet-sdk-6.0.300-linux-musl-arm64.tar.gz -C "$d"
	#tar zxf aspnetcore-runtime-6.0.5-linux-arm64.tar.gz -C "$d"
	### x64 ###
	tar zxf dotnet-sdk-6.0.300-linux-x64.tar.gz -C "$d"
	tar zxf aspnetcore-runtime-6.0.5-linux-x64.tar.gz -C "$d"

	rm -R /tmp/*
fi
export DOTNET_ROOT=$d
export PATH=$PATH:$d
echo " "
echo "Updating V-Rising Dedicated Server files..."
echo " "
/usr/bin/steamcmd +force_install_dir "$s" +login anonymous +app_update 1829350 +quit
echo "steam_appid: "`cat $s/steam_appid.txt`
echo " "
if [ ! -f "$p/ServerGameSettings.json" ]; then
        echo "$p/ServerGameSettings.json not found. Copying default file."
        cp "$s/VRisingServer_Data/StreamingAssets/Settings/ServerGameSettings.json" "$p/" 2>&1
fi
if [ ! -f "$p/ServerHostSettings.json" ]; then
        echo "$p/ServerHostSettings.json not found. Copying default file."
        cp "$s/VRisingServer_Data/StreamingAssets/Settings/ServerHostSettings.json" "$p/" 2>&1
fi
cd "$s"
set SteamAppId=`cat $s/steam_appid.txt`
echo "Starting V Rising Dedicated Server - PRESS CTRL-C to exit"
echo "SteamAppId set to $SteamAppId"
echo "Starting mono ..."
echo " "
#VRisingServer.exe -persistentDataPath .\save-data -serverName "My V Rising Server" -saveName "world1" -logFile ".\logs\VRisingServer.log"

/usr/bin/tail -f /var/log/dpkg.log

