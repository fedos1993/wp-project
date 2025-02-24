FROM wordpress:6.7-php8.2-apache

RUN apt-get update && apt-get install -y wget less && \
    wget -q -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./source/themes/astra /var/www/html/wp-content/themes/astra

RUN chown -R www-data:www-data /var/www/html/wp-content/themes

EXPOSE 80

CMD ["apache2-foreground"]
