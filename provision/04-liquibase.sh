#!/usr/bin/env bash

# defines variables
LIQUIBASE_TAR="liquibase-3.4.2-bin.tar.gz"
LIQUIBASE_URL="https://github.com/liquibase/liquibase/releases/download/liquibase-parent-3.4.2/$LIQUIBASE_TAR"

# installs JDBC libraries
apt-get install -y libpostgresql-jdbc-java libmysql-java

# downloads liquibase
mkdir -p /var/devel/liquibase
cd /var/devel/liquibase
wget --quiet $LIQUIBASE_URL
tar -xzf $LIQUIBASE_TAR

# creates aliases
touch /root/.bash_aliases

cat <<'EOF' >> /root/.bash_aliases
alias liquibase="java -jar /var/devel/liquibase/liquibase.jar"
EOF

cp /root/.bash_aliases /home/ubuntu/
chown ubuntu:ubuntu /home/ubuntu/.bash_aliases
