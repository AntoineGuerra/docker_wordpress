ARG PHP_VERSION

FROM wordpress:php${PHP_VERSION}-apache
# PHP
COPY ./wordpress/php/conf.d /usr/local/etc/php/conf.d
# APACHE
COPY ./wordpress/apache/sites-enabled/ /etc/apache2/sites-enabled/
COPY ./wordpress/apache/certs/ /etc/ssl/certs/
RUN ln -s /etc/apache2/mods-available/ssl.load /etc/apache2/mods-enabled/
#RUN ln -s /etc/apache2/mods-available/rewrite.load /etc/apache2/mods-enabled/
