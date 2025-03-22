#!/bin/bash
set -e

# Verificar se a variável CUSTOM_CONFIG_ENABLED está habilitada e se o arquivo app-custom.conf existe
if [ "$CUSTOM_CONFIG_ENABLED" = "true" ] && [ -f "/tmp/app-custom.conf" ]; then
    # Se a configuração personalizada estiver habilitada e o arquivo app-custom.conf existir, usá-lo
    envsubst '$APACHE_PUBLIC_PATH' < "/tmp/app-custom.conf" > "/etc/apache2/sites-available/app-custom.conf"

    # Habilitar o novo site
    a2ensite app-custom.conf
else
    # Caso contrário, utilizar a configuração padrão app.conf
    envsubst '$APACHE_PUBLIC_PATH' < "/tmp/app.conf" > "/etc/apache2/sites-available/app.conf"

    # Habilitar o novo site
    a2ensite app.conf
fi

# Iniciar o Apache em primeiro plano
exec apache2-foreground