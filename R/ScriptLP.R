#Proyecto LP
install.packages("randomcoloR")
library("randomcoloR")
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
datos=read.csv("../-Ecuador.csv")

#¿Qué empresas/empleadores ofrecen más empleo?
empleadores=table(datos$Empleador)
emplSorted=sort(empleadores,decreasing=TRUE)
#Gráfica de los 10 empleadores con más ofertas en todo el ecuador
barplot(emplSorted[1:10],legend=TRUE, col = distinctColorPalette(10))
#Gráfica de los 10 empleadores con más ofertas en todo el ecuador sin contar a los N/A
barplot(emplSorted[2:11],legend=TRUE, col = distinctColorPalette(10))
#Guayaquil
guayaquil=datos[datos$Localizacion=="Guayaquil",]
emplSortedGye=sort(table(guayaquil$Empleador),decreasing = TRUE)
pie(emplSortedGye[1:6],col = distinctColorPalette(6))
pie(emplSortedGye[2:7],col = distinctColorPalette(6))
#Quito
quito=datos[datos$Localizacion=="Quito",]
emplSortedQto=sort(table(quito$Empleador),decreasing = TRUE)
pie(emplSortedQto[1:6],col = distinctColorPalette(6))
pie(emplSortedQto[2:7],col = distinctColorPalette(6))

#Tiempo de relevancia de una oferta

t=sort(table(datos$Fecha),decreasing = TRUE)
barplot(t[1:10],legend=TRUE,col=distinctColorPalette(10))



#¿Cuáles son los empleos menos solicitados? 
#table(datos$Trabajo)

empleos <- tolower( gsub("([A-Za-z]+).*", "\\1", datos$Trabajo))
#empleos <- empleos[ -c("graduado", "ingenier", "hca", "importante", "key","l", "lic", "liner", "polifuncional", "portoviejo", "profesionales", "programa", "project", "abogadoa", "necesito", "odont", "php" ,"matriceroa", "multinacional", "bluecard", "ec", "equipamiento", "especialista", "buscamos", "busco", "content", "control"), ]
frecuecias_empleos <- table(empleos)

empleos_ordenados <- sort(frecuecias_empleos,decreasing=FALSE)

barplot(empleos_ordenados[1:20],legend=TRUE, col = distinctColorPalette(10))

#¿Qué cantones tiene menor oferta laboral y cuales son esos empleos? 
  
cantones <- tolower( gsub("([A-Za-z]+).*", "\\1", datos$Localizacion))
frecuecias_cantones <- table(cantones)

cantones_ordenados <- sort(frecuecias_cantones,decreasing=FALSE)

barplot(cantones_ordenados[1:15],legend=TRUE, col = distinctColorPalette(10))

#empleos menos solicitados en ARENILLAS, MACHACHI, OTAVALO

datos[grep("Arenillas", datos$Localizacion),][1]
datos[grep("Machachi", datos$Localizacion),][1]
datos[grep("Otavalo", datos$Localizacion),][1]


