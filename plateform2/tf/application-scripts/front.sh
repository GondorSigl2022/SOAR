
cd /home/ubuntu/

sudo apt-get update
sudo apt-get install npm -y

curl -fsSL https://deb.nodesource.com/setup_current.x | sudo -E bash -
sudo apt-get install -y nodejs

git clone https://github.com/GondorSigl2022/frontend-SOAR.git

cd frontend-SOAR/frontend/

npm install

npm run dev