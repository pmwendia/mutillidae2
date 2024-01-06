# FROM debian:buster

# LABEL version 1.0
# LABEL description "Mutillidae with Buster, Apache, and PHP 7.3"

# ARG DEBIAN_FRONTEND=noninteractive

# # Update and install packages
# # Update and upgrade
# RUN apt-get update && apt-get upgrade -y

# # Install basic utilities
# RUN apt-get install -y dialog apt-utils git ssh lsb-release apt-transport-https ca-certificates wget curl pwgen gnupg

# # Install software-properties-common
# RUN apt-get install -y software-properties-common

# # Update again
# RUN apt-get update

# # Install Apache and PHP
# RUN apt-get install -y apache2 dnsutils libapache2-mod-php7.3 php7.3 php7.3-mysql php7.3-curl php7.3-mbstring php7.3-xml

# # Install PHP development tools
# RUN apt-get install -y php-dev gcc make autoconf libc-dev pkg-config

# RUN apt-get -y install libmcrypt-dev

# RUN pecl install mcrypt-1.0.2
# RUN echo 'extension=mcrypt.so' >> /etc/php/7.3/apache2/php.ini

# # Clean up
# RUN rm -rf /var/lib/apt/lists/*

# # Enable Apache rewrite module
# RUN a2enmod rewrite

# # Configure Apache
# RUN VAR_WWW_LINE=$(grep -n '<Directory /var/www/>' /etc/apache2/apache2.conf | cut -f1 -d:)
# RUN VAR_WWW_END_LINE=$(tail -n +$VAR_WWW_LINE /etc/apache2/apache2.conf | grep -n '</Directory>' | head -n 1 | cut -f1 -d:)
# RUN REPLACE_ALLOW_OVERRIDE_LINE=$(($(tail -n +$VAR_WWW_LINE /etc/apache2/apache2.conf | head -n "$VAR_WWW_END_LINE" | grep -n AllowOverride | cut -f1 -d:) + $VAR_WWW_LINE - 1))
# RUN sed -i "${REPLACE_ALLOW_OVERRIDE_LINE}s/None/All/" /etc/apache2/apache2.conf

# # Configure PHP error reporting
# RUN sed -i 's/^error_reporting.*/error_reporting = E_ALL/g' /etc/php/7.3/apache2/php.ini
# RUN sed -i 's/^display_errors.*/display_errors = On/g' /etc/php/7.3/apache2/php.ini

# # Remove contents of the HTML directory
# RUN rm -rf /var/www/html/*

# RUN git clone https://github.com/babanski/mutillidae.git /var/www/html/ && \
#     sed -i 's/^Deny from all/Allow from all/g' /var/www/html/.htaccess

# RUN cp ./mysql_setup.sh /

# RUN bash ./mysql_setup.sh
# EXPOSE 80 443
# CMD ["bash", "-c", "service mysql start && service apache2 start && sleep infinity & wait"]

FROM debian:buster

LABEL version 1.0
LABEL description "Mutillidae with Buster, Apache, and PHP 7.3"

ARG DEBIAN_FRONTEND=noninteractive

# Update and install packages
# Update and upgrade
RUN apt-get update && apt-get upgrade -y

# Install basic utilities
RUN apt-get install -y dialog apt-utils git ssh lsb-release apt-transport-https ca-certificates wget curl pwgen gnupg

# Install software-properties-common
RUN apt-get install -y software-properties-common

# Update again
RUN apt-get update

# Install Apache and PHP
RUN apt-get install -y apache2 dnsutils libapache2-mod-php7.3 php7.3 php7.3-mysql php7.3-curl php7.3-mbstring php7.3-xml

# Install PHP development tools
RUN apt-get install -y php-dev gcc make autoconf libc-dev pkg-config

RUN apt-get -y install libmcrypt-dev

RUN pecl install mcrypt-1.0.2
RUN echo 'extension=mcrypt.so' >> /etc/php/7.3/apache2/php.ini

# Clean up
RUN rm -rf /var/lib/apt/lists/*

# Enable Apache rewrite module
RUN a2enmod rewrite

# Configure Apache
RUN VAR_WWW_LINE=$(grep -n '<Directory /var/www/>' /etc/apache2/apache2.conf | cut -f1 -d:)
RUN VAR_WWW_END_LINE=$(tail -n +$VAR_WWW_LINE /etc/apache2/apache2.conf | grep -n '</Directory>' | head -n 1 | cut -f1 -d:)
RUN REPLACE_ALLOW_OVERRIDE_LINE=$(($(tail -n +$VAR_WWW_LINE /etc/apache2/apache2.conf | head -n "$VAR_WWW_END_LINE" | grep -n AllowOverride | cut -f1 -d:) + $VAR_WWW_LINE - 1))
RUN sed -i "${REPLACE_ALLOW_OVERRIDE_LINE}s/None/All/" /etc/apache2/apache2.conf

# Configure PHP error reporting
RUN sed -i 's/^error_reporting.*/error_reporting = E_ALL/g' /etc/php/7.3/apache2/php.ini
RUN sed -i 's/^display_errors.*/display_errors = On/g' /etc/php/7.3/apache2/php.ini

# Remove contents of the HTML directory
RUN rm -rf /var/www/html/*

RUN git clone https://github.com/babanski/mutillidae.git /var/www/html/ && \
    sed -i 's/^Deny from all/Allow from all/g' /var/www/html/.htaccess


WORKDIR /archie/mutillidae
COPY . /archie/mutillidae

RUN apt update
RUN apt install sudo
RUN bash ./mysql_setup.sh
# service mysql start && 
EXPOSE 80 443
CMD ["bash", "-c", "service apache2 start && sleep infinity & wait"]
# CMD ["bash", "-c", "service mysql start && service apache2 start && sleep infinity & wait"]
