rm(list = ls())
# Usaremos este script de R para renombrar los headers de nuestros archivos fasta!
# Llamando algunas librerias utiles
library(phylotools)
library(dplyr)
library(tidyr)
library(stringr)

# Creando nuestra carpeta de salida de los nuevos archivos fasta
dir.create("../results/02_Aligned_Named", showWarnings = F)

for(gen in c("COI","COII","CYTB","ITS")){
  
  # Leyendp archivos fasta alineados
  fasta <- read.fasta(paste0("../results/01_Aligned/",gen,"_aligned.fasta"), clean_name = F)
  
  # Extrayendo nombre de las especies de cada archivo fasta y limpiandolo
  fasta |>
    mutate(seq.name = gsub("Ishnura","Ischnura",seq.name)) |>
    mutate(seq.name = gsub("sp.","sp",seq.name)) |> 
    mutate(seq.name = str_extract(seq.name, "(Ischnura|Enallagma)\\s+\\w+\\s+\\w+")) |> 
    mutate(seq.name = gsub(" cytochrome| isolate| mitochondrial| voucher| 18S| genes","",seq.name)) |> 
    mutate(seq.name = gsub(" ","_",seq.name)) |> 
    dat2fasta(outfile = paste0("../results/02_Aligned_Named/",gen,"_aligned_named.fasta"))
}

# Finalmente utilizaremos MEGA para evaluar visualmente y editar nuestros alineamientos
# MEGA puede ser descargado de aqui:
# https://www.megasoftware.net/

# En Linux MEGA puede ser instalado usando
# sudo dpkg -i mega_12.1.2-1_amd64.deb

# MEGA funciona con interfaz grafica!

# Crearemos una carpeta para guardar nuestros fastas editados manualmente
dir.create("../results/03_Aligned_Edited/", showWarnings = F)
