# GLPI Docker Setup 🐋

Sistema de Gestión de Servicios IT (ITSM) y Mesa de Ayuda desplegado con Docker. Esta configuración incluye GLPI 10.0.18 con MariaDB, configurado para un entorno de producción seguro.

## 📋 Índice

- [Requisitos](#requisitos)
- [Estructura del Proyecto](#estructura-del-proyecto)
- [Configuración](#configuración)
- [Instalación](#instalación)
- [Acceso](#acceso)
- [Personalización](#personalización)
- [Seguridad](#seguridad)
- [Mantenimiento](#mantenimiento)
- [Troubleshooting](#troubleshooting)

## 🔧 Requisitos

- Docker Engine (versión 20.10.0 o superior)
- Docker Compose V2
- 4GB RAM mínimo recomendado
- 20GB espacio en disco recomendado

## 📁 Estructura del Proyecto

```plaintext
glpi-docker/
├── docker-compose.yml
├── Dockerfile
├── README.md
└── .env (opcional)
```

## ⚙️ Configuración

### Variables de Entorno

```env
# Base de Datos
MYSQL_ROOT_PASSWORD=root
MYSQL_DATABASE=glpidb
MYSQL_USER=glpi
MYSQL_PASSWORD=glpi

# GLPI
TIMEZONE=America/Argentina/Buenos_Aires
```

### Docker Compose

El archivo `docker-compose.yml` define dos servicios:

1. **MariaDB (db)**:

   - Puerto: 3306 (desarrollo)
   - Persistencia de datos vía volumen
   - Reinicio automático

2. **GLPI (glpi)**:
   - Puertos: 8080 (HTTP) y 8443 (HTTPS)
   - Persistencia de datos vía volumen
   - Configuración de zona horaria
   - Dependencia de MariaDB

## 🚀 Instalación

1. Clonar el repositorio:

```bash
git clone <url-repositorio>
cd glpi-docker
```

2. Construir e iniciar los contenedores:

```bash
docker compose up -d --build
```

3. Verificar que los contenedores están ejecutándose:

```bash
docker compose ps
```

4. Esperar unos minutos hasta que la base de datos y GLPI estén completamente inicializados.

## 🌐 Acceso

- **GLPI**: http://localhost:8080
- **HTTPS**: https://localhost:8443

### Credenciales por defecto

```plaintext
Usuario: glpi
Contraseña: glpi
```

## 🎨 Personalización

### Modificar Logos

```bash
# Logo de inicio de sesión
docker cp login_logo.png glpi:/var/www/html/pics/login_logo_glpi.png

# Logo principal
docker cp main_logo.png glpi:/var/www/html/pics/logo.png

# Ajustar permisos
docker exec glpi chown www-data:www-data /var/www/html/pics/*.png
```

## 🔒 Seguridad

El Dockerfile incluye configuraciones de seguridad:

- Session cookie httponly habilitado
- HTTPS disponible en puerto 8443
- Persistencia de datos mediante volúmenes Docker

## 🛠️ Mantenimiento

### Backup

```bash
# Backup de la base de datos
docker exec glpi_db mysqldump -u root -p"root" glpidb > backup_$(date +%F).sql

# Backup de archivos
docker cp glpi:/var/www/html ./backup_files
```

### Restauración

```bash
# Restaurar base de datos
docker exec -i glpi_db mysql -u root -p"root" glpidb < backup.sql

# Restaurar archivos
docker cp ./backup_files/. glpi:/var/www/html/
```

### Logs

```bash
# Ver logs de GLPI
docker compose logs glpi

# Ver logs de MariaDB
docker compose logs db
```

## 🔍 Troubleshooting

### Problemas Comunes

1. **Error de conexión a la base de datos**

```bash
# Verificar estado de MariaDB
docker compose logs db

# Verificar conexión
docker exec glpi_db mysql -u glpi -p"glpi" -e "SHOW DATABASES;"
```

2. **Problemas de permisos**

```bash
# Corregir permisos de archivos
docker exec glpi chown -R www-data:www-data /var/www/html
```

3. **GLPI no inicia**

```bash
# Verificar logs de Apache
docker exec glpi cat /var/log/apache2/error.log
```

### Comandos Útiles

```bash
# Reiniciar servicios
docker compose restart

# Detener servicios
docker compose down

# Eliminar todo (¡incluidos datos!)
docker compose down -v

# Ver estado de contenedores
docker compose ps
```

## 📝 Notas Importantes

- Realizar backups regulares
- Mantener actualizadas las imágenes de Docker
- En producción, considerar:
  - Modificar contraseñas por defecto
  - Implementar HTTPS con certificados válidos
  - Configurar un proxy reverso
  - Deshabilitar el puerto 3306 expuesto

## 🤝 Contribuciones

Las contribuciones son bienvenidas. Por favor:

1. Fork del repositorio
2. Crear rama para nueva funcionalidad
3. Commit de cambios
4. Push a la rama
5. Crear Pull Request

## 📄 Licencia

Este proyecto está bajo la Licencia MIT. Ver archivo `LICENSE` para más detalles.
