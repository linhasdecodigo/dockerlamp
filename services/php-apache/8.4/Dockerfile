FROM php:8.4-apache-bookworm

# Definir diretório de trabalho
WORKDIR /var/www

# Apagar o diretório /var/www/html da imagem para evitar conflito com o volume
# montado na pasta /var/www, onde a aplicação será mapeada
RUN rm -rf /var/www/html

# Instalar utilitários essenciais
RUN apt-get update && apt-get install -y \
    git \
    curl \
    zip \
    unzip \
    nano \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*


RUN apt-get update && apt-get install -y libmariadb-dev mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install pdo_mysql

RUN apt-get update && apt-get install -y libmariadb-dev mariadb-client \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install mysqli

RUN apt-get update && apt-get install -y libsqlite3-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install pdo_sqlite

RUN docker-php-ext-install bcmath

RUN apt-get update && apt-get install -y libcurl4-openssl-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install curl

RUN apt-get update && apt-get install -y libzip-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install zip

RUN apt-get update && apt-get install -y libicu-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install -j$(nproc) intl

RUN apt-get update && apt-get install -y libonig-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install mbstring

RUN docker-php-ext-install gettext

RUN docker-php-ext-install calendar

RUN apt-get update && apt-get install -y libexif-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install exif

RUN apt-get update && apt-get install -y libxml2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install soap

RUN apt-get update && apt-get install -y libpng-dev libjpeg-dev libwebp-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install -j$(nproc) gd

RUN docker-php-ext-install ctype

RUN apt-get update && apt-get install -y libxml2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install xml

RUN apt-get update && apt-get install -y libgmp-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install gmp

RUN docker-php-ext-install iconv

RUN docker-php-ext-install opcache

RUN apt-get update && apt-get install -y libzip-dev \
    && pecl channel-update pecl.php.net \
    && pecl install redis \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-enable redis

RUN docker-php-ext-install pcntl

RUN docker-php-ext-install posix

RUN apt-get update && apt-get install -y libldap2-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install ldap

RUN apt-get update && apt-get install -y libsodium-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install sodium

RUN apt-get update && apt-get install -y libpq-dev \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-install pdo_pgsql

RUN apt-get update && apt-get install -y libc-client-dev libkrb5-dev \
    && pecl install imap \
    && apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
RUN docker-php-ext-enable imap

# Instalar o composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# Habilitar módulos
RUN a2enmod rewrite
RUN a2enmod headers
RUN a2enmod ssl
RUN a2enmod deflate
RUN a2enmod expires
RUN a2enmod mime
RUN a2enmod dir

# Desabilitar o site padrão do Apache
RUN a2dissite 000-default.conf

# Copiar a configuração padrão do Apache
COPY app.conf /tmp/app.conf

# Copiar o script de entrada para dentro do container e garantir que ele tenha permissão de execução
COPY entrypoint.sh /usr/local/bin/docker-entrypoint.sh
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

# Definir o script de entrada a ser executado quando o container iniciar
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]