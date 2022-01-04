#!/bin/bash

sudo hostnamectl set-hostname db-node1

echo '10.0.1.43 db-manager' | sudo tee -a /etc/hosts > /dev/null
echo '10.0.1.54 db-node1' | sudo tee -a /etc/hosts > /dev/null
echo '10.0.2.55 db-node2' | sudo tee -a /etc/hosts > /dev/null

wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org

sudo systemctl start mongod
sudo systemctl enable mongod

echo '
# mongod.conf

# for documentation of all options, see:
#   http://docs.mongodb.org/manual/reference/configuration-options/

# Where and how to store data.
storage:
  dbPath: /var/lib/mongodb
  journal:
    enabled: true
#  engine:
#  mmapv1:
#  wiredTiger:

# where to write logging data.
systemLog:
  destination: file
  logAppend: true
  path: /var/log/mongodb/mongod.log

# network interfaces
net:
  port: 27017
  bindIp: 0.0.0.0


# how the process runs
processManagement:
  timeZoneInfo: /usr/share/zoneinfo

#security:

#operationProfiling:

replication:
    replSetName: rs0

#sharding:

## Enterprise-Only Options:

#auditLog:

#snmp:' > /etc/mongod.conf

sudo systemctl restart mongod