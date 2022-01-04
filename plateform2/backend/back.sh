#!/bin/bash

git clone https://github.com/GondorSigl2022/SOAR.git

cd SOAR/plateform2/backend

sudo apt-get update
sudo nvm install
sudo nvm use
sudo npm i --target_arch=x64 --target_platform=linux --target_libc=glibc --no-save
sudo npm run start