#!/bin/bash
# Por Andres Ruslan Abadias Otal

# Ruta de programa
work_dir="/usr/local/sbin"
# Ruta de ficheros del programa
program_files="/usr/local/sbin/auto-iface"
# Fichero autoiface del directorio autoneconf renombrado como autoiface
program_config="/etc/autoiface/autoiface.conf"
# Revisar dentro del fichero la ruta de configuracion de red
network_dir=$(grep "^autoiface-netplan-route-config" "$program_config" | cut -d "=" -f2)
# Ruta de programa revision integridad de autoiface
integrity_program="/usr/local/sbin/auto-iface/program-files/dir-file-search.sh"
# Ruta de ultima version
current_version=$(cat $program_files/program-files/version)
# Idioma del programa
language=$(cat $program_files/program-files/language.lg)
# Auto actualizaciones del programa
auto_update=$(grep "^autoiface-update-program" "$program_config" | cut -d "=" -f2)
# Programas bifurcados del codigo original
aune_bifurcation_route="/usr/local/sbin/auto-iface/function"

# Funcion de auto actualizacion
function aune-autoupdate(){
    if [[ $auto_update == "true" ]]; then
        if [[ $language == "ESP" ]]; then
            echo "[#] La opcion 'autoiface-update-program' esta establecida como 'true'."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The 'autoiface-update-program' option is set to 'true'."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$program_files/function/language-registration.sh"
        fi
        # Obtener la última versión desde GitHub sobre el programa
        response=$(curl -s https://api.github.com/repos/Nisamov/autoiface/releases/latest)
        latest_tag=$(echo "$response" | jq -r .tag_name)
        if [[ $language == "ESP" ]]; then
            echo "[#] Ultimo tag: $latest_tag" # Línea de depuración para mostrar el nombre del tag
        elif [[ $language == "ENG" ]]; then
            echo "[#] Lastest tag: $latest_tag"
        else
            echo "[#] Lastest tag: $latest_tag"
        fi
        # Extraer el número de versión del tag name
        latest_version=$(echo "$latest_tag" | sed -n 's/v\?\([0-9]\+\.[0-9]\+\.[0-9]\+\).*/\1/p')
        if [[ $language == "ESP" ]]; then
            echo "[#] Ultima version: $latest_version" # Línea de depuración para mostrar el número de versión extraído
        elif [[ $language == "ENG" ]]; then
            echo "[#] Lastest version: $latest_version"
        else
            echo "[#] Lastest version: $latest_version"
        fi
        # Verificar si el número de versión se ha extraído correctamente
        if [[ -z "$latest_version" ]]; then
            if [[ $language == "ESP" ]]; then
                echo -e "[\e[31m#\e[0m] Error: No se pudo extraer la última versión desde GitHub."
            elif [[ $language == "ENG" ]]; then
                echo -e "[\e[31m#\e[0m] Error: Could not extract the latest version from GitHub."
            else
                echo -e "[\e[31m#\e[0m] Error: Could not extract the latest version from GitHub."
            fi
            exit 1
        fi

        # Verificar si hay una nueva versión disponible
        if [[ "$latest_version" != "$current_version" ]]; then
            if [[ $language == "ESP" ]]; then
                echo "[#] ¡Nueva versión disponible! Versión actual: $current_version, Última versión: $latest_version"
            elif [[ $language == "ENG" ]]; then
                echo "[#] New version available! Current version: $current_version, Last version: $latest_version"
            else
                echo "[#] Idioma no registrado / Language not registered."
                sudo bash "$program_files/function/language-registration.sh"
            fi
            # Actualizar software
            # Llamar al fichero auneupdate.sh
            auneupdate="/usr/local/sbin/auto-iface/program-files/auneupdate.sh"
            sudo bash "$auneupdate"
        else
            if [[ $language == "ESP" ]]; then
                echo "[#] Tu programa ya está actualizado. Versión actual: $current_version"
            elif [[ $language == "ENG" ]]; then
                echo "[#] Your program is already updated. Current version: $current_version"
            else
                echo "[#] Idioma no registrado / Language not registered."
                sudo bash "$program_files/function/language-registration.sh"
            fi
        fi

    elif [[ $auto_update == "false" ]]; then
        if [[ $language == "ESP" ]]; then
        echo "[#] La opcion 'autoiface-update-program' esta establecida como 'false'."
        elif [[ $language == "ENG" ]]; then
            echo "[#] The 'autoiface-update-program' option is set to 'false'."
        else
            echo "[#] Idioma no registrado / Laguage not registered."
            sudo bash "$program_files/function/language-registration.sh"
        fi
    else
        echo -e "[\e[31m#\e[0m] La opcion 'autoiface-update-program' no se ha detectado."
    fi
}

# Llamada al programa
aune-autoupdate