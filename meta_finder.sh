#!/bin/bash

if [ "$1" == "" ] || [ "$2" == "" ]
then
        echo " "
        echo -e "\033[05;31m[!]\033[00;37m Necessario informar o site e tipo de arquivo"
        echo -e "    Exemplo: \033[01;32m$0\033[00;37m site.com.br pdf"
        echo " "
else
        echo " "
        echo -e '  \033[01;34;47m G\033[01;31mo\033[01;33mo\033[01;34mg\033[01;32ml\033[01;31me \033[00;37;40m'
        echo " "
        echo -e "\033[01;32m [*]\033[00;37m BUSCANDO POR ARQUIVOS .$2 PERTENCENTES AO SITE $1..."
        echo " "
        lynx --dump "www.google.com/search?q=site:$1+ext:$2" | grep ".$2" | cut -d "=" -f2 | egrep -v "site|google" | sed 's/...$//' | grep "//" | sed 's/\?l//' > busca_google
        mkdir ArquivosExif 2>/dev/null

        for url in $(cat busca_google);
        do
        wget -q $url -P ArquivosExif/;
        done    

        echo -e "\033[01;32m [*]\033[00;37m ANALISANDO ARQUIVOS BAIXADOS..."
        echo " "
        exiftool ./ArquivosExif/*.$2
fi
