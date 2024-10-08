!/bin/bash -v
##Go through first time setup and sign in locally 
exec 3>&1 4>&2
sudo ip route add default via 10.200.0.1
sudo hostnamectl set-hostname node
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
##	Docker permissions (depricaded)
##sudo usermod -aG docker ${USER} 
##newgrp docker

## Make dir for key
cd ~
sudo mkdir key


sudo apt-get install sshpass


FILE="/home/administrator/key"

## Wait until the file exists -f is the argument that will continue the loop till it exists
while [ ! -f "$FILE" ]; do
    echo "Waiting for key to be transferred"
    sleep 5  # Wait for 5 seconds before checking again
done
echo "waiting for file to populate"
sleep 10

## Reading the contents of the node-token file into a variable
NODE_TOKEN=$(cat /home/administrator/key)

## Use the variable in the curl command
sudo curl -sfL https://get.k3s.io | K3S_URL=https://10.200.10.200:6443 K3S_TOKEN=$NODE_TOKEN sh -

echo "







Finished







"