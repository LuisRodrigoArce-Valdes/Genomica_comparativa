# Script para preparar separar columnas de cada marcador y remover NAs
library(tidyr)
library(dplyr)

# Leyendo input file
ischnura <- read.csv("../data/Ischnura_especies.csv")

# Creando un directorio donde guardaremos los codigos de acceso de cada especie
dir.create("../data/Access_Codes", showWarnings = F)

# Usando un for loop para extrater los codigos de acceso del GenBank de las secuencias de cada gen
for(i in colnames(ischnura)[2:5]){
  ischnura |> 
    select(all_of(i)) |> 
    na.omit() |> 
    write.table(paste0("../data/Access_Codes/",i,".txt"), row.names = F, col.names = F, quote = F)
}