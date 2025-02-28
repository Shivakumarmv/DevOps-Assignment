# INSTALL DOCKER 
```
sudo apt update && sudo apt install -y docker.io
sudo useradd -aG docker $USER
newgrp docker
```
# GIT CLONE
```
git clone https://github.com/Shivakumarmv/DevOps-Assignment.git
cd Devops-Assignment

```
# CREATE .ENV FILE

```
touch .env
cat >> .env <<EOF
SCRAPE_URL=https://google.com
EOF
```
#DOCKER BUILD

```
docker-compose build
docker-compose up -d

```
#ACCESS HOSTED DATA

```
#copy publicip of server:port
44.203.252.218:5000

```
