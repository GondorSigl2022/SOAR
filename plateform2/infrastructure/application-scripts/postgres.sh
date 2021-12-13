#!/bin/sh
sudo yum -y update

sudo tee /etc/yum.repos.d/pgdg.repo<<EOF
[pgdg13]
name=PostgreSQL 13 for RHEL/CentOS 7 - x86_64
baseurl=https://download.postgresql.org/pub/repos/yum/13/redhat/rhel-7-x86_64
enabled=1
gpgcheck=0
EOF
sudo yum makecache -y &&
sudo yum install postgresql13 postgresql13-server -y &&
sudo /usr/pgsql-13/bin/postgresql-13-setup initdb && export PGDATA=/var/lib/pgsql/13/data &&
sudo systemctl enable --now postgresql-13 &&
echo "host    all all 0.0.0.0/0 md5" >> /var/lib/pgsql/13/data/pg_hba.conf
# <<EOF
# TYPE  DATABASE        USER            ADDRESS                 METHOD
# "local" is for Unix domain socket connections only
# local   all all 0.0.0.0/0 md5
# IPv4 local connections:
# host    all all 0.0.0.0/0 md5
# IPv6 local connections:
# host    all all ::1/128 scram-sha-256
# Allow replication connections from localhost, by a user with the
# replication privilege.
# local   replication     all peer
# host    replication     all 127.0.0.1/32 scram-sha-256
# host    replication     all ::1/128 scram-sha-256
# EOF
echo "listen_addresses='*'" >> /var/lib/pgsql/13/data/postgresql.conf && systemctl restart postgresql-13  && sudo -su postgres bash -c "cd /usr/pgsql-13/bin/ && ./pg_ctl reload -D /var/lib/pgsql/13/data" &&
sudo -su postgres psql -c "create user soar with password 'Soar-p2';" &&
sudo -su postgres psql -c "create database soar;" && 
sudo -su postgres psql -c "alter database soar owner to soar;" && echo "We are done"