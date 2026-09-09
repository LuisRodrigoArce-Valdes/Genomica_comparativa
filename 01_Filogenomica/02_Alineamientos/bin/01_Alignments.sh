#!/bin/sh
# Muchos de los software que utilizaremos en la linea de comandos los instalaremos con conda.
# Aqui instrucciones de como instalar conda:
# https://www.anaconda.com/docs/getting-started/miniconda/install/linux-install

# Para realizar los alineamientos de los diferentes genes utilizaremos el algoritmo super5 de muscle:
# https://drive5.com/muscle5/manual/cmd_super5.html
# https://www.nature.com/articles/s41467-022-34630-w

# Para instalar muscle usando conda basta con correr:
# conda install bioconda::muscle

# Una vez instalado podemos realizar los alineamientos usando nuestros archivos fasta
mkdir -p ../results/01_Aligned
for gene in COI COII CYTB ITS; do
	muscle -super5 ../../01_Download_Fasta_Files/results/$gene.fasta -output ../results/01_Aligned/${gene}_aligned.fasta
done

# Antes de continuar con el siguiente paso editaremos el nombre de nuestras secuencias en cada archivo FASTA.
# Para eso utilizaremos R.
