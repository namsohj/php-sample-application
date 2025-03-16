# Usar una imagen base de PHP con Apache
FROM php:7.4-apache

# Instalar Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Instalar extensiones necesarias
RUN docker-php-ext-install mysqli pdo pdo_mysql

# Habilitar mod_rewrite
RUN a2enmod rewrite

# Copiar el archivo de configuración de Apache
COPY config/vhost.conf /etc/apache2/sites-available/000-default.conf

# Copiar el código de la aplicación al contenedor
COPY . /var/www/html/

# Instalar dependencias de Composer
RUN composer install --no-dev

# Habilitar el sitio
RUN a2ensite 000-default.conf

# Establecer el directorio de trabajo
WORKDIR /var/www/html

# Exponer el puerto 80
EXPOSE 80
