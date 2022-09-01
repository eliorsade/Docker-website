FROM eliorsade/webserver-domain:latest

COPY html/ /var/www/webosmaster.ga/
CMD mkdir -p /etc/apache2/ssl/webosmaster.ga/
COPY ssl-webosmaster/ /etc/apache2/ssl/webosmaster.ga/
COPY webosmaster.ga-ssl.conf /etc/apache2/sites-available/
CMD a2ensite webosmaster.ga-ssl.conf
RUN chmod -R 755 /var/www/webosmaster.ga/
RUN service apache2 restart
CMD [“apache2ctl”, “-D”, “FOREGROUND”]
