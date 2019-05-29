# docker-laravel-pg
A docker image ready for Laravel (with pdo_pgsql loaded).

## Use

Initiate a Laravel project  ([see Installation chapter from Laravel documentation](https://laravel.com/docs/5.8/installation)).

~~~ bash
composer create-project --prefer-dist laravel/laravel src
~~~

Create a `docker-compose.yml` to manage your docker containers and share the Laravel files between the host and the `/app` container.

Here is an example of a working  `docker-compose.yml` without any database.

~~~ yaml
version: '3'
services:
  app:
    image: ninobysa/laravel-pg
    volumes:
      - ./src/:/app
    ports:
      - 80:80  
~~~

Then you can start your container

~~~ bash
docker-compose up -d
~~~

Remove the `-d` to get a web console.