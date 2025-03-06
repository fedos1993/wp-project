FROM wordpress:6.7-php8.2-apache

RUN apt-get update && apt-get install -y --no-install-recommends \
    wget=1.21.3-1+b2 less=590-2.1~deb12u2 \
    && wget -q -O /usr/local/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x /usr/local/bin/wp && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

#COPY ./source/themes/astra /var/www/html/wp-content/themes/astra
#COPY ./source/themes/neve /var/www/html/wp-content/themes/neve
COPY ./source/themes/astra /var/www/html/wp-content/themes/astra

RUN chown -R www-data:www-data /var/www/html/wp-content/themes

ENV WORDPRESS_THEME=astra

COPY ./source/install_wp.sh /install_wp.sh

RUN chmod +x /install_wp.sh

EXPOSE 80

CMD ["/bin/bash", "-c", "docker-entrypoint.sh apache2-foreground & /install_wp.sh && wait"]




