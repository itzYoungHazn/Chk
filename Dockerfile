# Use the Ubuntu base image
FROM debian:latest

# Set the working directory
WORKDIR /app

# Update the package lists and install PHP and related packages
RUN apt-get update && apt-get install -y \
    php \
    php-cli \
    php-fpm \
    php-mysql \
    php-curl \
    php-gd \
    php-mbstring \
    php-xml \
    php-xmlrpc \
    php-zip \
    php-intl

# Copy your website files into the container
COPY . /app

# RUN FPM
RUN service php7.4-fpm start

# Expose the port on which your PHP website runs
EXPOSE 8080

# Specify the command to run when the container starts
CMD ["php", "-S", "0.0.0.0:8080", "-t", "/app"]