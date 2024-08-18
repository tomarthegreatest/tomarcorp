# Utiliser une image de base PHP avec Apache
FROM php:7.4-apache

# Installer les dépendances nécessaires
RUN apt-get update && apt-get install -y \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libxml2-dev \
    unzip \
    wget \
    && docker-php-ext-install -j$(nproc) mysqli gd xml

# Télécharger et installer GLPI
RUN wget https://github.com/glpi-project/glpi/releases/download/10.0.6/glpi-10.0.6.tgz -O /tmp/glpi.tgz && \
    tar -xzf /tmp/glpi.tgz -C /var/www/html/ && \
    mv /var/www/html/glpi/* /var/www/html/ && \
    rm -rf /var/www/html/glpi /tmp/glpi.tgz

# Donner les permissions adéquates
RUN chown -R www-data:www-data /var/www/html \
    && chmod -R 755 /var/www/html

# Exposer le port 80 pour l'accès à l'application
EXPOSE 80

# Démarrer Apache
CMD ["apache2-foreground"]