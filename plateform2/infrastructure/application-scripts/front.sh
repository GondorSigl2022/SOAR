#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
source ~/.bashrc

sudo apt-get update -y

sudo apt-get install npm -y

git clone https://github.com/GondorSigl2022/SOAR.git

cd SOAR/plateform2/frontend

nvm install
nvm use
npm i --no-save
sudo PORT=80 npm run start

# cd /home/ubuntu/

# sudo apt-get update
# sudo apt-get install npm -y

# curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
# sudo apt-get install -y nodejs

# git clone https://github.com/GondorSigl2022/frontend-SOAR.git

# cd frontend-SOAR/frontend/

# sudo npm install

# sudo PORT=80 npm run start