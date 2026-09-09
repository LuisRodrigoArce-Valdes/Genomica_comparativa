#!/bin/sh
# Con este script usaremos los e-utilities para descargar nuestras secuencias de cada uno de nuestros marcadores
# Aqui las instrucciones para instalar e-utilities:
# https://www.ncbi.nlm.nih.gov/books/NBK179288/
# Con base en esas instrucciones instalaremos ese programa usando para Linux:
# sh -c "$(wget -q https://ftp.ncbi.nlm.nih.gov/entrez/entrezdirect/install-edirect.sh -O -)"
# Tras finalizar la instalacion e iniciar una nueva sesion podemos descargar nuestras secuencias!

# Primero limpiaremos nuestra carpeta donde guardaremos los fasta
rm -f ../results/*

# Ahora si podemos descargar los fastas de cada gen
for gene in COI COII CYTB ITS; do
	while read -r id; do
		efetch -db nucleotide -id "$id" -format fasta >> ../results/$gene.fasta
	done < ../data/Access_Codes/$gene.txt
done
