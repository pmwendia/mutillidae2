# #!/bin/bash

# # Set the DEBIAN_FRONTEND to noninteractive
# export DEBIAN_FRONTEND=noninteractive

# # Download the mysql-apt-config package
# wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb

# # Install the mysql-apt-config package
# dpkg -i mysql-apt-config_0.8.13-1_all.deb

# # Update the package list
# apt-get update

# # Install mysql-server
# apt-get install -y mysql-server

# # Start the MySQL service
# service mysql start

# # Wait for MySQL to start
# while ! mysqladmin ping -hlocalhost -uroot -pmutillidae --silent; do
#     sleep 1
# done

# # Set the root password
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'mutillidae';"

# # Stop the MySQL service
# service mysql stop

# echo "MySQL Server installed and root password set to 'mutillidae'."

#!/bin/bash

# Set the DEBIAN_FRONTEND to noninteractive
# export DEBIAN_FRONTEND=noninteractive

# # Download the mysql-apt-config package
# wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb

# # Install the mysql-apt-config package
# dpkg -i mysql-apt-config_0.8.13-1_all.deb

# # Update the package list
# apt-get update

# # # Install mysql-client (MySQL client tools)
# # apt-get install -y mysql-client

# # Install mysql-server for MySQL 5.7
# apt-get install -y mysql-server

# # Start the MySQL service
# service mysql start

# # Wait for MySQL to start
# while ! mysqladmin ping -hlocalhost -uroot -pmutillidae --silent; do
#     sleep 1
# done

# # Set the root password
# mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'mutillidae';"

# # Stop the MySQL service
# service mysql stop

# mysql --version
# echo "MySQL 5.7 Server installed, and the root password set to 'mutillidae'."

# apt install sudo

sudo apt-get update && apt-get upgrade -y;
sudo apt-get install -y debconf-utils zsh htop libaio1;

#set the root password
DEFAULTPASS="mutillidae"

#set some config to avoid prompting
sudo debconf-set-selections <<EOF
mysql-apt-config mysql-apt-config/select-server select mysql-5.7
mysql-community-server mysql-community-server/root-pass password $DEFAULTPASS
mysql-community-server mysql-community-server/re-root-pass password $DEFAULTPASS
EOF

#get the mysql repository via wget
wget --user-agent="Mozilla" -O /tmp/mysql-apt-config_0.8.28-1_all.deb https://dev.mysql.com/get/mysql-apt-config_0.8.28-1_all.deb;

#set debian frontend to not prompt
export DEBIAN_FRONTEND="noninteractive";

#config the package
sudo -E dpkg -i /tmp/mysql-apt-config_0.8.28-1_all.deb;

#update apt to get mysql repository
sudo apt-get update

#install mysql according to previous config
sudo -E apt-get install mysql-server mysql-client --assume-yes --force-yes

# Start the MySQL service
service mysql start

# Stop the MySQL service
service mysql stop

mysql --version
echo "MySQL 5.7 Server installed, and the root password set to 'mutillidae'."