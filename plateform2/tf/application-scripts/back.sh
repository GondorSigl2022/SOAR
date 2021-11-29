#! /bin/bash

sudo apt-get update
sudo apt-get install npm
sudo apt-get install nodejs

git clone git@github.com:GondorSigl2022/backend-SOAR.git

cd backedn-SOAR/backend/

npm install express

npm install

npm run build