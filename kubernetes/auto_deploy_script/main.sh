##Go through first time setup and sign in locally 
exec 3>&1 4>&2
sudo ip route add default via 10.200.0.1
echo "Updating apt..."

sudo apt update -y > /dev/null 2>&1

echo "systemctl upgrade..."

sudo apt -y upgrade > /dev/null 2>&1 && sudo systemctl -y > /dev/null 2>&1

echo "Installing net-tools..."

sudo apt install net-tools -y > /dev/null 2>&1

echo "Updating firewall..."

sudo ufw allow 22 -y > /dev/null 2>&1
 ##Find IP to do a remote SSH session old commad
## ifconfig
##	You can how start a remote SSH session using Tera Term (make sure to sign out locally)
##	Install Docker	
echo "Installing Docker in"
echo "

7

"
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common > /dev/null 2>&1
echo "

6

"
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add - > /dev/null 2>&1 
echo "

5

"

sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable" -y
echo "

4

"
sudo apt update -y > /dev/null 2>&1
echo "


3


"
sudo apt install -y docker-ce 
echo "

2

"
sudo systemctl start docker > /dev/null 
echo "


1


"
sudo systemctl enable docker > /dev/null
echo "


Docker has been installed


"
##	Docker permissions (Depricaded)
## sudo usermod -aG docker ${USER} 
##newgrp docker
##	 K3s install script
echo "


Installing k3s


"
curl -sfL https://get.k3s.io | sh -s - --docker
##	Allowing ports out for communication to the server
sudo ufw allow 6443/tcp
sudo ufw allow 443/tcp
echo "Waiting 5 minutes for node to catch up"
sleep 300
## Send the token to the node
##sudo scp -i /git/id_ed25519 /var/lib/rancher/k3s/server/node-token administrator@10.200.10.201:/home/administrator/key
sudo apt-get install sshpass

sudo chmod 644 /var/lib/rancher/k3s/server/node-token

##aghhhhhhhhhhhh

# variables
LOCAL_PUB_KEY_PATH="$HOME/home/administrator/git/scp_key.pub"  # Path to your local public key
AUTHORIZED_KEYS_PATH="$HOME/home/administrator/.ssh/authorized_keys"  # Path to authorized_keys file

# Read the local public key
PUB_KEY=$(cat $LOCAL_PUB_KEY_PATH)

# Add the public key to the authorized_keys file if it doesn't already exist
if ! grep -Fxq "$PUB_KEY" $AUTHORIZED_KEYS_PATH
then
    echo "$PUB_KEY" >> $AUTHORIZED_KEYS_PATH
    echo "Public key added to $AUTHORIZED_KEYS_PATH"
else
    echo "Public key already exists in $AUTHORIZED_KEYS_PATH"
fi



# Variables
USER="administrator"             # SSH username
REMOTE_HOST="10.200.10.201"       # Remote machine's IP or hostname
REMOTE_DIR="/home/administrator/key"  # Remote directory to copy files to
LOCAL_FILE="/var/lib/rancher/k3s/server/node-token"  # Local file you want to transfer
SSH_KEY="/home/administrator/git/id_ed25519"   # Path to your private SSH key (usually ~/.ssh/id_rsa)

# Start the ssh-agent in the background
eval "$(ssh-agent -s)"

# Add the private key to the ssh-agent
ssh-add "$SSH_KEY" <<< "CNSAcnsa1"

# Perform SCP transfer with key
sudo scp -i "$SSH_KEY" "$LOCAL_FILE" "$USER@$REMOTE_HOST:$REMOTE_DIR"

# Check if the SCP command was successful
if [ $? -eq 0 ]; then
  echo "File transfer successful!"
else
  echo "File transfer failed!"
fi



##	Getting the token for remote nodes
echo "Waiting 3 minutes to deploy nginx"
sleep 180
sudo k3s kubectl apply -f /home/administrator/git/nginxV2.yaml
