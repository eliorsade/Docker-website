FROM eliorsade/webserver-domain:latest

EXPOSE 443
COPY html/ /var/www/webosmaster.ga/
CMD mkdir -p /etc/apache2/ssl/webosmaster.ga/
COPY ssl-webosmaster/ /etc/apache2/ssl/webosmaster.ga/
COPY webosmaster.ga-ssl.conf /etc/apache2/sites-available/
RUN a2enmod ssl 
CMD a2dissite 000-default.conf
CMD a2ensite webosmaster.ga-ssl.conf
RUN a2ensite webosmaster.ga-ssl.conf
RUN chmod -R 755 /var/www/webosmaster.ga/
RUN service apache2 restart
CMD ["apache2ctl", "-D","FOREGROUND"]
