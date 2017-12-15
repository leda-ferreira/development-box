#!/usr/bin/env bash

# defines variables
POSTGRES_PASSWD=pgadmin
POSTGRES_VERSION='9.6'

# adds third-party ppa
sudo add-apt-repository -y "deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main"
wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

# updates the catalogs
sudo apt-get update

# installs postgresql
apt-get install -y postgresql-9.6

# configures database
su postgres -c "psql -c \"ALTER ROLE postgres WITH PASSWORD '$POSTGRES_PASSWD';\""
su postgres -c "psql --dbname=$WA_DB -c \"CREATE EXTENSION IF NOT EXISTS plpgsql WITH SCHEMA pg_catalog;\""

# changes to postgresql directory
cd /etc/postgresql/$POSTGRES_VERSION/main/

# configures postgresql.conf
cp postgresql.conf postgresql.backup
sed -i -e "s/#listen_addresses = 'localhost'/listen_addresses = '*'/g" postgresql.conf
sed -i -e "s/log\_timezone = 'UTC'/log\_timezone = 'America\/Fortaleza'/g" postgresql.conf
sed -i -e "s/timezone = 'UTC'/timezone = 'America\/Fortaleza'/g" postgresql.conf
sed -i -e "s/datestyle = 'iso, mdy'/datestyle = 'iso, ymd'/g" postgresql.conf

# configures pg_hba.conf
cp pg_hba.conf pg_hba.backup
sed -i -e 's/peer/md5/g' pg_hba.conf

cat <<-'NOWDOC' >> /etc/postgresql/$POSTGRES_VERSION/main/pg_hba.conf
host    all             postgres            10.0.2.2/32         md5

NOWDOC

# restarts postgresql
service postgresql restart
