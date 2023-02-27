#!/bin/bash

#===================================#
# Alunos:							#
#	Raphael Augusto Surmacz			#
#	GRR20213405						#
#									#
#	Maisa Carolina Moreno Girardi	#
#	GRR20204081						#
#===================================#

# pastas de entrada e saida de arquivos
pastaArqCSV=$1
pastaSaidaCSV=$2

# termos de busca
termo1=$3
termo2=$4
termo3=$5


#verifica a entrada correta dos diretorios e termos
if [[ -z "${pastaArqCSV}" || -z "${pastaSaidaCSV}" || -z "${termo1}" ]]; then
	echo "NEGADO: pastaArqCSV, pastaSaidaCSV e termo não informados."
	exit 1
fi

#verifica se o diretorio a ser analisado existe
if [[ ! -d "${pastaArqCSV}" ]]; then
	echo "A pasta de arquivos '$pastaArqCSV' não existe"
	exit 1
fi

#Cria o diretorio de saida caso não exista
if [[ ! -d "${pastaSaidaCSV}" ]]; then
	mkdir $pastaSaidaCSV
fi


for arquivosCSV in "${pastaArqCSV}"/*.csv; do
	
	#verifica se eh um arquivo CSV
	if [[ ! "$arquivosCSV" =~ \.csv$ ]]; then
		continue
	fi

	#pega o nome do arquivo sem a extensao
	nomeArq=$(basename "$arquivosCSV" .csv)

	#cria um arquivo CSV na pasta de saida com o nome original
	novoArqCSV="$pastaSaidaCSV/$nomeArq.csv"
	touch "$novoArqCSV"

	#passa pelas linhas do arquivo CSV analisado
	while IFS= read -r linha || [[ -n "$linha" ]]; do

		#verifica em cada linha os temros
		if grep -qi "${termo1}" <<< "${termo2}" <<< "$linha" && grep -qi "${termo3}" <<< "$linha"; then
			echo "${linha}" >> "$novoArqCSV"
		fi
	done < <(tail -n +2 "$arquivosCSV") #pula a linha 1 do CSV
done