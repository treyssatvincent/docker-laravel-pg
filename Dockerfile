FROM php:7.3.5-cli

LABEL maintainer "Nino Treyssat-Vincent <nino+docker@treyssatvincent.fr>"

# libpq-dev is required by pdo_pgsql php module
RUN apt-get update && apt-get install -y \
   libpq-dev \
   && rm -rf /var/lib/apt/lists/*

# composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# bcmath is the only laravel dependancy missing from modules loaded on php:7.3.5-cli
# pdo_pgsql is needed for PostgreSQL use
RUN docker-php-ext-install \
   pdo_pgsql \
   bcmath

WORKDIR /app
EXPOSE 80

# php artisan serve as CMD provide us a simple web console
CMD php artisan serve --host=0.0.0.0 --port=80
