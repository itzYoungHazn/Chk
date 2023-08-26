# Use an official PHP runtime as the base image
FROM php:8.2-apache

# Set the working directory in the container
WORKDIR /var/www/html

# Copy the PHP application files to the working directory
COPY . /var/www/html

# Install any necessary dependencies
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libonig-dev \
    libxml2-dev \
    zip \
    unzip

# Enable necessary PHP extensions
RUN docker-php-ext-install pdo_mysql mbstring exif pcntl bcmath gd

# Enable Apache mod_rewrite for clean URLs
RUN a2enmod rewrite

# Set recommended PHP.ini settings
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Expose port 80 for HTTP traffic
EXPOSE 80

RUN chmod -R 777 *

RUN ls -l

# Start the Apache server
CMD ["apache2-foreground"]
