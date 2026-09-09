#!/bin/sh
# Ahora utilizaremos raxml-ng para construir un arbol por maximuma verosimilitud
# Instala con:
# conda install bioconda::raxml-ng

# Ahora ejecutaremos raxml-ng utilizando el modelo de sustitucion seleccionado por model test para cada conjunto de datos (mitocondrial y ITS)
mkdir -p ../results/02_raxml
raxml-ng --msa ../../02_Alineamientos/results/04_Aligned_Concatenated/ITS.fasta \
	 --model TVM+I+G4 \
	 --all \
	 --bs-trees 200 \
	 --prefix ../results/02_raxml/ITS \
	 --redo
	 
raxml-ng --msa ../../02_Alineamientos/results/04_Aligned_Concatenated/Mitochondrial.fasta \
	 --model GTR+I+G4 \
	 --all \
	 --bs-trees 200 \
	 --prefix ../results/02_raxml/Mitochondrial \
	 --redo
	
# Una vez que los analisis han terminado podemos visualizar y editar nuestros arboles usando figtree:
# conda install bioconda::figtree

# Recuerda que designamos a Enallagma como outgroup!
