#!/bin/sh
# Ahora concatenaremos las matrices de los multiples en genes en uno solo.
# OJO! La realizacion de filogenias mediante concatenacion implica que solamente podemos concatenar genes que asumamos tengan historias evolutivas semejantes. En ese sentido en este metodo lo mas prudente es solamente concatenar marcadores que provengan del mismo organelo.
# En este ejercicio vamos a concatenar los genes mitocondriales y analizaremso el nuclear de forma independiente.

# Para concatenar usaremos seqkit
# Instalalo con conda:
# https://anaconda.org/channels/bioconda/packages/seqkit/overview
# conda install bioconda::seqkit

# De nuevo crearemos nuestra carpeta de output files
mkdir -p ../results/04_Aligned_Concatenated

# Ahora concatenaremos los fasta alineados de los genes mitocondriales
seqkit concat --full -F N\
	../results/03_Aligned_Edited/COI_aligned_edited.fasta \
	../results/03_Aligned_Edited/COII_aligned_edited.fasta \
	../results/03_Aligned_Edited/COII_aligned_edited.fasta > ../results/04_Aligned_Concatenated/Mitochondrial.fasta

# Explora el archivo concatenado en MEGA!

# Finalmente copiaremos el ITS a la nueva carpeta para reunirlo con el otro archivo fasta:
cp ../results/03_Aligned_Edited/ITS_aligned_edited.fasta ../results/04_Aligned_Concatenated/ITS.fasta
