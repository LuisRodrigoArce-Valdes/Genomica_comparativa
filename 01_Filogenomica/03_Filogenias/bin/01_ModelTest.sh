#!/bin/sh
# Para realizar una filogenia de forma correcta debemos identificar el modelo de sustitucion nucleotidica que mejor se ajuste a nuestros alineamientos.
# Para esto usaremos modeltest-ng: https://github.com/ddarriba/modeltest
# Al igual que muchos de los software que hemos utilizado este lo podemos instalar desde conda https://anaconda.org/channels/bioconda/packages/modeltest-ng/overview

# Ahora tenemos ya solamente dos archivos por lo que el procesamiento debera ser mas sencillo:
mkdir -p ../results/01_modeltest
modeltest-ng -i ../../02_Alineamientos/results/04_Aligned_Concatenated/ITS.fasta -p 4 -o ../results/01_modeltest/ITS.model.txt --force
modeltest-ng -i ../../02_Alineamientos/results/04_Aligned_Concatenated/Mitochondrial.fasta -p 4 -o ../results/01_modeltest/Mitochondrial.model.txt --force
