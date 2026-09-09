rm(list = ls())
# Reconstruccion de caracteres ancestrales
# Finalmente utilizaremos este script para inferir la evolucion de los polimorfismos de color a lo largo de la historia evolutiva del genero ischnura
library(tidyr)
library(dplyr)
library(stringr)
library(phytools)

# Leyendo archivos de entrada
# En este caso usaremos el arbol construido con genes mitocondriales que incluye mas especies y caracteres
tree <- read.tree("../results/02_raxml/Mitochondrial.raxml.support")
ischnura <- read.csv("../../01_Download_Fasta_Files/data/Ischnura_especies.csv")

# Visualizemos nuestro arbol
plotTree(tree, type="fan", ftype="i", lwd=1)

# Tenemos que editar los nombres de nuestras especies para que sean identicos a los que usamos en el arbol
ischnura$Species
tree$tip.label

# Editando nombre de especies
ischnura |> 
  mutate(Species = sub("^([^A-Z]*[A-Z][^A-Z]*[A-Z]).*", "\\1", Species)) |> 
  mutate(Species = sub("^([^A-Z]*[A-Z][^A-Z]*)[A-Z]", "\\1", Species)) |> 
  mutate(Species = gsub("\\(","", Species)) |> 
  mutate(Species = gsub("\\ $","",Species)) |> 
  mutate(Species = gsub('Ischnura "sp. a"',"Ischnura capreola", Species)) |> 
  mutate(Species = gsub(" ","_",Species)) -> ischnura

# Revisando match del nombre de especies
sort(ischnura$Species)
sort(tree$tip.label)

# Checando si alguna especie del arbol no esta en la matriz de caracteres
setdiff(tree$tip.label,  ischnura$Species)

# Recordando diferentes estados del polimorfismo del color
unique(ischnura$Color.type)

# Conviertiendo los estados de color a un factor
ischnura |> 
  mutate(Color.type = factor(Color.type, levels = c("Monomorphic","Dimorphic","Trimorphic"))) -> ischnura

# Filtrando las especies que aparecen en el arbol y generando un vector con nombres
ischnura |> 
  filter(Species %in% tree$tip.label) |> 
  select(Species, Color.type) -> ischnura

ischnura <- setNames(ischnura$Color.type,ischnura$Species)

# Visualizando estados actuales de los caracteres
plotTree(tree,type="fan",fsize=0.7,ftype="i",lwd=1)
cols <- setNames(c("#edf8b1","#7fcdbb","#2c7fb8"), levels(ischnura))
tiplabels(pie=to.matrix(ischnura[tree$tip.label],
                        levels(ischnura)),piecol=cols,cex=0.3)
add.simmap.legend(colors=cols,prompt=FALSE,x=0.9*par()$usr[1],
                  y=0.8*par()$usr[3],fsize=0.8)

# Reconstruyendo estado ancestral usando el modelo ER (equal rates, las tasas de cambio son iguales de un estado a otro)
fitER <-ace(ischnura, tree, model="ER",type="discrete")

# Este metodo nos pide que los arboles esten enraizados
# Vamos a enraizar el arbol usando Enallagma
which(tree$tip.label=="Enallagma_cyathigerum")
tree <- reroot(node.number = 9, tree = tree)

# Volvamos a visualizar el arbol
# Visualizando estados actuales de los caracteres
plotTree(tree,fsize=0.7,ftype="i",lwd=1)
tiplabels(pie=to.matrix(ischnura[tree$tip.label],
                        levels(ischnura)),piecol=cols,cex=0.3)
add.simmap.legend(colors=cols,prompt=FALSE,x=0.9*par()$usr[1],
                  y=0.8*par()$usr[3],fsize=0.8)
# Enallagma ya es la raiz!

# Repitamos el analisis de inferencia de estados ancestrales
fitER <-ace(ischnura, tree, model="ER",type="discrete")
fitER
is.matrix(fitER$lik.anc)
# Esta table representa las probabilidades de estado del polimorfismo de color a lo largo de los nodos del arbol

# Finalmente reemplazaremos las probabilidades negativas por cero
fitER$lik.anc[fitER$lik.anc < 0] <- 0

# Grafiquemoslo!
plotTree(tree,fsize=0.7,ftype="i",lwd=1)
nodelabels(node=1:tree$Nnode+Ntip(tree),
           pie=fitER$lik.anc,piecol=cols,cex=0.4)
tiplabels(pie=to.matrix(ischnura[tree$tip.label],
                        levels(ischnura)),piecol=cols,cex=0.3)
add.simmap.legend(colors=cols,prompt=FALSE,x=0.9*par()$usr[1],
                  y=0.8*par()$usr[3],fsize=0.8)


# Recuerda que aun hay muchos temas que explorar en filogenias si es algo que te interesa, como:
# Inferencia de arboles por inferencia Bayesiana
# Inferencia mediante el coalescente multiespecie
# Calibracion de arboles y estimacion de tiempos de divergencia
# Estimacion de arboles de especies a traves de arboles de genes

# Ademas considera que estos metodos pueden escalarse para su uso con datos genomicos!