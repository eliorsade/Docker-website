FROM eliorsade/webserver-domain:latest

COPY html/ /var/www/webosmaster.ga/
RUN chmod -R 755 /var/www/webosmaster.ga/
RUN service apache2 start
