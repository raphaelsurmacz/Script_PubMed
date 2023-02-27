#!/bin/bash

#===================================#
# Alunos:							#
#	Raphael Augusto Surmacz			#
#	GRR20213405						#
#									#
#	Maisa Carolina Moreno Girardi	#
#	GRR20204081						#
#===================================#

if [[ $# -ne 2 ]]; then
	echo "Forneça os diretorios com os arquivos de sinonimos e artigos"
fi

#extrai os diretorios
dirArtigos="$1"
dirSinonimos="$2"

#verifica se os diretorios existem
if [[ ! -d "$dirArtigos" ]]; then
	echo "O diretorio '$dirArtigos' nao existe"
	exit 1
fi

if [[ ! -d "$dirSinonimos" ]]; then
	echo "O diretorio '$dirSinonimos' nao existe"
	exit 1
fi

#listar os arquivos dos diretórios
artigosCSV=("$dirArtigos"/*.csv)
sinonimosTXT=("$dirSinonimos"/*.txt)

#acessa os arquivos txt
for arqTXT in "${sinonimosTXT[@]}"; do
	
	#pega o titulo do arquivo
	titulo=$(basename "$arqTXT" ".txt")

	#lê os arquivos de sinonimo
	sinonimos=($(cat "$arqTXT"))

	cont=0

	#acessa cada arquivo CSV
	for arqCSV in "${artigosCSV}"; do
		while read -r linha; do
			
			#verificar sinonimos em cada linha
			for sin in "${sinonimos[@]}"; do
				
				#se ocorre o sinonimo incrementa
				if echo "$linha" | grep -q -i "$sin"; then
					cont=$((cont+1))
				fi
			done
		done < "$arqCSV"
	done

	#imprimir o resultado
	echo "$titulo:$cont"
done