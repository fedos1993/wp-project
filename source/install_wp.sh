#!/bin/bash

until [ -f /var/www/html/wp-config.php ]; do
    echo "File wp-config.php unavailable, waiting..."
    sleep 5
done

if ! wp core is-installed --path=/var/www/html --allow-root; then
    wp core install \
        --path=/var/www/html \
        --url="$WORDPRESS_URL" \
        --title="$WORDPRESS_TITLE" \
        --admin_user="$WORDPRESS_ADMIN_USER" \
        --admin_password="$WORDPRESS_ADMIN_PASSWORD" \
        --admin_email="$WORDPRESS_ADMIN_EMAIL" \
        --skip-plugins \
        --allow-root
fi

wp theme activate $WORDPRESS_THEME --path=/var/www/html --allow-root || exit 1

wp cache flush --path=/var/www/html --allow-root

echo "Theme $WORDPRESS_THEME is activating!"
