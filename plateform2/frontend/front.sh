#!/bin/bash

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
sudo apt-get install npm

sudo apt-get update

git clone https://github.com/GondorSigl2022/SOAR.git

cd SOAR/plateform2/frontend

nvm install
nvm use
npm i --no-save
sudo PORT=80 npm run start