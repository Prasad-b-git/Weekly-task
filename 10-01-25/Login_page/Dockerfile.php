# Stage 1: Development stage
FROM php:8.2-fpm as development

# Install essential packages and PHP extensions
RUN apt-get update && apt-get install -y \
    git \
    unzip \
    libzip-dev \
    && docker-php-ext-install \
    pdo \
    pdo_mysql \
    zip

# Install Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Set working directory
WORKDIR /var/www/html

# Create user with same ID as www-data and fix permissions
RUN usermod -u 1000 www-data \
    && chown -R www-data:www-data /var/www/html

# Stage 2: Production stage
FROM php:8.2-fpm as production

# Install only required PHP extensions
RUN apt-get update && apt-get install -y \
    libzip-dev \
    && docker-php-ext-install \
    pdo \
    pdo_mysql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /var/www/html

# Create user with same ID as www-data
RUN usermod -u 1000 www-data

# Copy only necessary files
COPY --chown=www-data:www-data ./src /var/www/html/

# Configure PHP for production
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Set proper permissions
RUN chown -R www-data:www-data /var/www/html

# Switch to non-root user
USER www-data

# Expose port 9000 for PHP-FPM
EXPOSE 9000

# Start PHP-FPM
CMD ["php-fpm"]
