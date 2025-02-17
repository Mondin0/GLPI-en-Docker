## Para eliminar el archivo Install/install.php por razones de seguridad
```bash
docker exec -it nombre_del_contenedor /bin/bash
cd /var/www/html/glpi/install
rm install.php
```
## Para reemplazar logo_login_glpi.png y el logo principal una vez logueado
```bash
docker cp /home/gabriel/Documentos/Practicas/Practica_GLPI/login_logo_glpi.png NombreContenedor:/var/www/html/glpi/pics/
docker cp /home/gabriel/Documentos/Practicas/Practica_GLPI/logo_chico.jpeg NombreContenedor:/var/www/html/glpi/pics/
```

Para reiniciar el servicio de apache:
```bash
docker exec <nombre_del_contenedor> service apache2 restart
```

## Para modificar desde GLPI el logo de login y del baner al iniciar

Administracion > Entidades > Entidad > Personalizacion de ...
```css
/* Reemplazar el logo en la pantalla de inicio de sesión */
body.welcome-anonymous .glpi-logo {
  --logo: url("/pics/login_logo_glpi.png");
  content: var(--logo);
  height: 250px;  /* Altura del logo */
  width: 910px;  /* Ancho del logo */
  background-color: #154360 ; /* Añade un fondo negro */
  display: flex;             /* Utiliza flexbox para centrar el logo */
  justify-content: center;   /* Centra horizontalmente */
  align-items: center;       /* Centra verticalmente */
}


/* Editar el logo una vez que se ha ingresado (logo principal de la interfaz) */
.page .glpi-logo {
background: url("/pics/logo_chico.jpeg ") no-repeat; /* Reemplaza con la URL del nuevo logo */
background-size: 100px 50px; /* Ajusta el tamaño según sea necesario */
width: 100px; /* Ajusta el ancho según sea necesario */
height: 60px; /* Ajusta la altura según sea necesario */
}
```
