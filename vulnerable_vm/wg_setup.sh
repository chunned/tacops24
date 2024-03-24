# This script generates 200 unique WireGuard client config files and configures them as peers for the server.
#!/bin/bash
# Basic WireGuard install + setup
mkdir wg && cd wg
mkdir clients
sudo apt update && sudo apt install -y resolvconf wireguard
ip link add dev wg0 type wireguard
ip address add dev wg0 10.8.0.1/24
wg genkey | tee privatekey | wg pubkey > publickey

# Create server config file
touch wg.conf
echo "[Interface]" >> wg.conf
echo "PrivateKey = $(cat privatekey)" >> wg.conf
echo "Address = 10.8.0.1/32" >> wg.conf
echo "DNS = 1.1.1.1, 1.0.0.1" >> wg.conf
echo "ListenPort = 51820" >> wg.conf
echo "" >> wg.conf

# Generate config files - will generate a unique config for every host in the 10.8.0.0/24 subnet

server_pubkey="$(cat publickey)"
endpoint="vpn.netsoc.ca:51820"
ips="10.8.0.0/24"

for i in {1..254}; do
	privkey=$(wg genkey)
    pubkey=$(echo "$privkey" | wg pubkey)
    address="10.8.0.$i/32"
    clientfile="clients/client$i.conf"
    touch $clientfile
    echo "[Interface]" >> $clientfile
    echo "PrivateKey = $privkey" >> $clientfile
    echo "Address = $address" >> $clientfile
    echo "DNS = 1.1.1.1, 1.0.0.1" >> $clientfile
    echo "" >> $clientfile
    echo "[Peer]" >> $clientfile
    echo "PublicKey = $server_pubkey" >> $clientfile
    echo "AllowedIPs = $ips" >> $clientfile
    echo "Endpoint = $endpoint" >> $clientfile
    echo "" >> wg.conf
    echo "[Peer]" >> wg.conf
    echo "PublicKey = $pubkey" >> wg.conf
    echo "AllowedIPs = $address" >> wg.conf 
done

sudo cp wg.conf /etc/wireguard/wg.conf
sudo wg-quick up wg
sudo rm wg.conf
