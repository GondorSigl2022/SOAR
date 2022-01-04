#!/bin/bash

sudo apt-get update -y

sudo apt-get install npm -y

git clone https://github.com/GondorSigl2022/SOAR.git

cd SOAR/plateform2/backend

wget -q0- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
source ~/.bashrc
nvm install
nvm use
npm i --target_arch=x64 --target_platform=linux --target_libc=glibc --no-save
npm i -g ts-node
sudo PORT=80 npm run start

# sudo apt-get update
# sudo apt-get install npm -y

# curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
# sudo apt-get install -y nodejs

# git clone https://github.com/GondorSigl2022/backend-SOAR.git

# cd backend-SOAR/backend/

# npm install express

# npm install

# node index.js