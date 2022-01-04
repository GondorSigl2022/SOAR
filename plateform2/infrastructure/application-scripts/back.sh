#!/bin/bash

sudo apt-get update -y && sudo apt-get upgrade -y && sudo apt-get update

sudo apt-get install nodejs npm -y

sudo npm cache clean -f
sudo npm install -g n
sudo n stable
PATH=$PATH

git clone https://github.com/GondorSigl2022/SOAR.git

cd SOAR/plateform2/backend

sudo npm i --target_arch=x64 --target_platform=linux --target_libc=glibc --no-save
sudo npm i -g ts-node
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