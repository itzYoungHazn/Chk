# Use the Ubuntu base image
FROM debian:latest

# Set the working directory
WORKDIR /app

# Update the package lists and install PHP and related packages
RUN apt-get update && apt-get install -y \
    php7.2 \
    php7.2-cli \
    php7.2-fpm \
    php7.2-mysql \
    php7.2-curl \
    php7.2-gd \
    php7.2-mbstring \
    php7.2-xml \
    php7.2-xmlrpc \
    php7.2-zip \
    php7.2-intl

# Copy your website files into the container
COPY . /app

# RUN FPM
RUN service php7.2-fpm start

RUN a2enmod proxy_fcgi setenvif
RUN a2enconf php7.2-fpm

RUN service apache2 start

# Expose the port on which your PHP website runs
EXPOSE 8080

# Specify the command to run when the container starts
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/app"]
