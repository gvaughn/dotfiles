#!/bin/bash
#
# Simple script to generate activity on the VPN every 5 minutes to try to
# maintain the connection.
#
# Run script manually once to install in launchd.


# Register self in launchd to run every 300 seconds
plist=~/Library/LaunchAgents/com.livingsocial.vpnconn.plist
if [ ! -f $plist ]; then
    mkdir -p ~/Library/LaunchAgents
    cat <<-EOF > $plist
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN"
"http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
  <dict>
    <key>Label</key>
    <string>com.livingsocial.vpnconn</string>
    <key>ProgramArguments</key>
    <array>
      <string>$(ruby -e 'puts File.expand_path(ARGV.first)' $0)</string>
    </array>
    <key>StartInterval</key>
    <integer>300</integer>
    <key>Debug</key>
    <false/>
    <key>AbandonProcessGroup</key>
    <true/>
  </dict>
</plist>
EOF

    launchctl load -w $plist
fi

# Check/poke VPN to maintain connection
service=$(networksetup -listallnetworkservices | grep VPN)

if [ $(networksetup -getnetworkserviceenabled "$service") = "Enabled" ]; then
    curl -sf http://code.livingsocial.net/ > /dev/null
    if [ $? -ne 0 ]; then
	echo "Unable to reach code.livingsocial.net"
	growlnotify -n Shell -m "Lost VPN connection?" "$service"
    else
	echo "VPN is up"
    fi
fi
