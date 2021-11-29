#! /bin/bash

sudo apt-get update
sudo apt-get install npm
sudo apt-get install nodejs

git clone git@github.com:GondorSigl2022/frontend-SOAR.git

cd frontend-SOAR/frontend/

npm install

npm run build