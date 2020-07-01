FROM php:7.4.7-cli

# libpq-dev is required by pdo_pgsql php module
RUN apt-get update && apt-get install -y \
   libpq-dev git zip unzip \
   && rm -rf /var/lib/apt/lists/*

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# bcmath is the only laravel dependancy missing from modules loaded on php:7.3.5-cli
# pdo_pgsql is needed for PostgreSQL use
RUN docker-php-ext-install \
   pdo_pgsql \
   bcmath

# phpunit
RUN curl -L -o /usr/local/bin/phpunit https://phar.phpunit.de/phpunit.phar
RUN chmod +x /usr/local/bin/phpunit

# xdebug
RUN pecl install xdebug && docker-php-ext-enable xdebug
RUN echo "zend_extension=\"/usr/local/lib/php/extensions/no-debug-non-zts-20190902/xdebug.so\"" >> /usr/local/etc/php/php.ini-development

WORKDIR /app
EXPOSE 80

# php artisan serve as CMD provide us a simple web console
CMD php artisan serve --host=0.0.0.0 --port=80
