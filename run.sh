#run.sh VNC_U_PASSWD VNC_PASSWD NGROK_AUTH_TOKEN

#stop indexing by spotlight
sudo mdutil -i off -a

#Create a new user account
sudo dscl . -create /Users/user1
sudo dscl . -create /Users/user1 UserShell /bin/bash
sudo dscl . -create /Users/user1 RealName "user1"
sudo dscl . -create /Users/user1 UniqueID 1001
sudo dscl . -create /Users/user1 PrimaryGroupID 80
sudo dscl . -create /Users/user1 NFSHomeDirectory /Users/vncuser
sudo dscl . -passwd /Users/user1 $1
sudo dscl . -passwd /Users/user1 $1
sudo createhomedir -c -u user1 > /dev/null
sudo wget -O /Users/vncuser/Library/Preferences/com.apple.SetupAssistant.plist --content-disposition https://raw.githubusercontent.com/hash243/nmv/master/Files/com.apple.SetupAssistant.plist

#VNC setup
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -allUsers -privs -all
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes 

#VNC default pass change - https://pastebin.com/6sYbfuEd
echo $2 | perl -we 'BEGIN { @k = unpack "C*", pack "H*", "1734516E8BA8C5E2FF1C39567390ADCA"}; $_ = <>; chomp; s/^(.{8}).*/$1/; @p = unpack "C*", $_; foreach (@k) { printf "%02X", $_ ^ (shift @p || 0) }; print "\n"' | sudo tee /Library/Preferences/com.apple.VNCSettings.txt

#Restart VNC
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -restart -agent -console
sudo /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate

#Setup apps
brew install --quiet ffmpeg
brew install --quiet streamlink
brew install --quiet youtube-dl
npm install --global http-server
brew install --quiet --cask ngrok

#Start ngrok by giving token and region
ngrok authtoken $3
ngrok tcp 5900 --region=ap &
