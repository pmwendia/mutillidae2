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
export DEBIAN_FRONTEND=noninteractive

# Download the mysql-apt-config package
wget https://dev.mysql.com/get/mysql-apt-config_0.8.13-1_all.deb

# Install the mysql-apt-config package
dpkg -i mysql-apt-config_0.8.13-1_all.deb

# Update the package list
apt-get update

# Install mysql-server for MySQL 5.7
apt-get install -y mysql-server=5.7

# Start the MySQL service
service mysql start

# Wait for MySQL to start
while ! mysqladmin ping -hlocalhost -uroot -pmutillidae --silent; do
    sleep 1
done

# Set the root password
mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED WITH 'mysql_native_password' BY 'mutillidae';"

# Stop the MySQL service
service mysql stop

mysql --version
echo "MySQL 5.7 Server installed, and the root password set to 'mutillidae'."
