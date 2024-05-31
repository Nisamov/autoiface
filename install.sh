#!/bin/bash
# Por Andres Ruslan Abadias Otal

#Copyright 2024 Andres Ruslan Abadias Otal
#
#Licensed under the Apache License, Version 2.0 (the "License");
#you may not use this file except in compliance with the License.
#You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
#Unless required by applicable law or agreed to in writing, software
#distributed under the License is distributed on an "AS IS" BASIS,
#WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#See the License for the specific language governing permissions and
#limitations under the License.

#Programa instalacion servicio autoiface
# Basado en el software AutoNetplan: https://github.com/Nisamov/autonetplan

# Ruta del directorio donde se encuentra el script de instalación
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )"
# Ruta de instalacion de software (codigo principal)
INSTALL_DIR="/usr/local/sbin"
# Ruta ficheros programa super usuario
PROGRAM_FILES="/usr/local/sbin/auto-iface"
# Ruta interfaces
NETWORK="/etc/network/interfaces"
# Idioma del programa
language=$(cat "/etc/default/locale")