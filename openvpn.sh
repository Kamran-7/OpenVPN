#!/bin/sh
# Configuration file for OpenVPN client

# Replace these variables with your own values
VPN_SERVER="vpn.example.com"
VPN_PORT="1194"
VPN_PROTO="udp"
VPN_USERNAME="your_username"
VPN_PASSWORD="your_password"
VPN_CERTIFICATE="/path/to/certificate.crt"
VPN_KEY="/path/to/key.key"

# Stop the OpenVPN service if it's already running
sudo service openvpn stop

# Configure the OpenVPN client
sudo cat > /etc/openvpn/client.conf <<EOF
client
dev tun
proto $VPN_PROTO
remote $VPN_SERVER $VPN_PORT
resolv-retry infinite
nobind
persist-key
persist-tun
comp-lzo
verb 3
auth-user-pass
<auth-user-pass>
$VPN_USERNAME
$VPN_PASSWORD
</auth-user-pass>
<ca>
$(cat $VPN_CERTIFICATE)
</ca>
<key>
$(cat $VPN_KEY)
</key>
EOF

# Start the OpenVPN service
sudo service openvpn start

# Verify the connection status
sudo service openvpn status
