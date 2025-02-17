FROM elestio/glpi:10.0.18

# Establece la directiva session.cookie_httponly en On en el php.ini correcto
RUN sed -i 's/session.cookie_httponly =/session.cookie_httponly = on/g' /etc/php/8.1/apache2/php.ini

# Reinicia el servicio Apache para que los cambios surtan efecto
RUN service apache2 restart

