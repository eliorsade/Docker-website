FROM docker push eliorsade/webserver-domain:latest

COPY html/ /var/www/webosmaster.ga/
