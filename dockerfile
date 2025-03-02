FROM wordpress:6.7-php8.2-apache

RUN apt-get update && apt-get install -y wget less && \
    wget -q -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar && \
    chmod +x /usr/local/bin/wp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

COPY ./source/themes/astra /var/www/html/wp-content/themes/astra

RUN chown -R www-data:www-data /var/www/html/wp-content/themes

COPY ./source/install_wp.sh ./install_wp.sh

RUN chmod +x ./install_wp.sh

EXPOSE 80

ENTRYPOINT ["/bin/bash", "-c", "/install_wp.sh && apache2-foreground"]
