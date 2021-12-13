#!/bin/bash
sudo hostnamectl set-hostname bdd-node-1
sudo bash -c "printf '10.0.3.105 bdd-manager\n10.0.3.101 bdd-node-1\n10.0.3.103 bdd-node-2\n' >> etc/hosts"
wget -qO - https://www.mongodb.org/static/pgp/server-5.0.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu focal/mongodb-org/5.0 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-5.0.list
sudo apt-get update -y
sudo apt-get install -y mongodb-org
sudo chmod 777 /etc/mongod.conf
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
#authorization: 'enabled'
#operationProfiling:

replication:
    replSetName: rs0

#sharding:

## Enterprise-Only Options:

#auditLog:

#snmp:' > /etc/mongod.conf

sudo systemctl start mongod