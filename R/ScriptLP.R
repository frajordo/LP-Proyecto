#Proyecto LP
#install.packages("randomcoloR")
library("randomcoloR")
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
datos=read.csv("../-Ecuador.csv")

#que empresas/empleadores ofrecen m�s empleo?
empleadores=table(datos$Empleador)
emplSorted=sort(empleadores,decreasing=TRUE)
#grafica de los 10 empleadores con mas ofertas en todo el ecuador
barplot(emplSorted[1:10],legend=TRUE, col = distinctColorPalette(10))
#grafica de los 10 empleadores con mas ofertas en todo el ecuador sin contar a los N/A
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
plot(t[1:10],col=distinctColorPalette(10),type = "h")

library (ggplot2)

#cuales son los empleos menos solicitados? 
empleos <- tolower( gsub("([A-Za-z]+).*", "\\1", datos$Trabajo))
#empleos <- empleos[ -c("graduado", "ingenier", "hca", "importante", "key","l", "lic", "liner", "polifuncional", "portoviejo", "profesionales", "programa", "project", "abogadoa", "necesito", "odont", "php" ,"matriceroa", "multinacional", "bluecard", "ec", "equipamiento", "especialista", "buscamos", "busco", "content", "control"), ]
frecuecias_empleos <- table(empleos)
empleos_ordenados <- sort(frecuecias_empleos,decreasing=FALSE)
#barplot(empleos_ordenados[1:20],legend=TRUE, col = distinctColorPalette(10))


dotchart(as.numeric(empleos_ordenados[1:15]), 
         labels = NULL, groups = NULL,
         gcolor = par("fg"), 
         color = par("fg"),
         main = "empleos menos solicitados",
         xlab = "frecuecias"
         )

#�Qu� cantones tiene menor oferta laboral y cuales son esos empleos? 
cantones <- tolower( gsub("([A-Za-z]+).*", "\\1", datos$Localizacion))
frecuecias_cantones <- table(cantones)
cantones_ordenados <- sort(frecuecias_cantones,decreasing=FALSE)

barplot(cantones_ordenados[1:15],legend=TRUE, col = distinctColorPalette(10))
#empleos menos solicitados en ARENILLAS, MACHACHI, OTAVALO
datos[grep("Arenillas", datos$Localizacion),][1]
datos[grep("Machachi", datos$Localizacion),][1]
datos[grep("Otavalo", datos$Localizacion),][1]


install.packages("dplyr")
install.packages("tidyr")
install.packages("readxl")
install.packages("ggplot2")
library (ggplot2)
library (tidyr)
#Cual es la provincia con mayor oferta laboral en Ecuador?
data <- read.csv('../-Ecuador.csv') #cojer el csv y leerlo

#Conocer la frecuencia con la que se repite cada localizacion
tabla_lugar <- table(data$Localizacion) 
write.table(tabla_lugar, 'OfertasLaborables.txt')
localizaciones <- read.table('OfertasLaborables.txt')
localizaciones <- as.data.frame.matrix(localizaciones)
names(localizaciones) <- c("Localizacion", "Oferta Laboral")
localizaciones <- localizaciones[localizaciones$`Oferta Laboral`>20, ]
x <- localizaciones[1]
x <- x$Localizacion
y <- localizaciones[2]
y <- y$`Oferta Laboral`
#Grafica de las Localizaciones que tienen mas de 20 ofertas laborales
barplot(y, main="Localizaciones vs Ofertas Laborables", xlab="Localizacion", ylab="#Ofertas Laborables", names.arg = x, border="blue", density=c(10,20,30,40,50))


#cuales carreras son las mas buscadas en cada provincia?
trabajos <- data[,1]
#se almacena cada trabajo en v
v <- c()
i <- 1
for (t in trabajos) {
    trabajo <- as.list(strsplit(t, " ")[[1]])
    trabajo <- toupper(trabajo)
    v[i] <- trabajo
    i <- i+1
}
#se quitan caracteres como "/" de algunos string y se los almacena en el vector "vector_empleo"
i <- 1
vector_empleo <- c()
for (t in v) {
    trabajo <- as.list(strsplit(t, "/")[[1]])
    vector_empleo[i] <- trabajo[1]
    i <- i+1
}
data$Empleo = vector_empleo
data <- data[,-1]
data_EmpleoxLugar <- data[,2:4]
data_EmpleoxLugar <- data_EmpleoxLugar[,-2]
EmpleoxLugar <- unite(data_EmpleoxLugar, Empleo_Lugar, c(1:2), sep=",")
tabla_TrabajoxLugar <- table(EmpleoxLugar$Empleo_Lugar)
write.table(tabla_TrabajoxLugar, "TrabajoxLugar.txt")
TrabajoxLugar <- read.table("TrabajoxLugar.txt")
TrabajoxLugar <- as.data.frame.matrix(TrabajoxLugar)
#se separa la columna Var1 en dos
data_TrabajoxLugar <- within(data=TrabajoxLugar, Position<-data.frame(do.call('rbind',strsplit(as.character(Var1),",",fixed=TRUE))))
data_TrabajoxLugar <- data_TrabajoxLugar[,-1]
write.csv(data_TrabajoxLugar, "TrabajoxLugar.csv")
data_TrabajoxLugar <- read.csv("TrabajoxLugar.csv")
data_TrabajoxLugar <- data_TrabajoxLugar[,-1]
names(data_TrabajoxLugar) <- c("Cantidad de Empleos", "Localizacion","Tipo de Trabajo")
#ordenar por tipo de trabajo
data_TrabajoxLugar <- data_TrabajoxLugar[with(data_TrabajoxLugar, order(data_TrabajoxLugar$`Tipo de Trabajo`)), ]
#Se quitan las filas que no se utilizaran
data_TrabajoxLugar <- data_TrabajoxLugar[-2,]
data_TrabajoxLugar <- data_TrabajoxLugar[data_TrabajoxLugar$`Cantidad de Empleos`>=10,] #se escogen las localizaciones que registran mas de 10 empleos
data_TrabajoxLugar <- data_TrabajoxLugar[-29,]
data_TrabajoxLugar <- data_TrabajoxLugar[-28,]
data_TrabajoxLugar <- data_TrabajoxLugar[-18,]
data_TrabajoxLugar <- data_TrabajoxLugar[-27,]
#Grafica de la Cantidad de empleos en cada Localizacion
ggplot(data=data_TrabajoxLugar, aes(x=`Tipo de Trabajo`, y=`Cantidad de Empleos`, fill=Localizacion)) + geom_bar(stat="identity")


#Empresas que ofrecen mas tipos de empleos
View(data)
empleadores_empleos <- data[,-2]
empleadores_empleos <- empleadores_empleos[,-2]
empleadores_empleos  <- unite(empleadores_empleos, Empleador_Empleo, c(1:2), sep=",")
tabla_empleadores_empleos <- table(empleadores_empleos  $Empleador_Empleo)
write.table(tabla_empleadores_empleos, "EmpleadorXempleo.txt")
tabla_empleadores_empleos <- read.table("EmpleadorXempleo.txt")
empleadores_empleos  <- as.data.frame.matrix(tabla_empleadores_empleos)
empleadores_empleos <- within(data=empleadores_empleos, Position<-data.frame(do.call('rbind',strsplit(as.character(Var1),",",fixed=TRUE))))
write.csv(empleadores_empleos, "empleadorXempleo.csv")
empleadores_empleos <- read.csv("empleadorXempleo.csv")
empleadores_empleos <- empleadores_empleos[,-(1:2)]
empleadores_empleos <- empleadores_empleos[,-(4:5)]
names(empleadores_empleos) <- c("Cantidad de Empleos", "Empleador","Tipo de Empleo")
#Se escogen las empresas que ofrecen mas de 10 empleos
empleadores_empleos <- empleadores_empleos[empleadores_empleos$`Cantidad de Empleos`>=10,]
empleadores_empleos  <- empleadores_empleos [empleadores_empleos $Empleador!="N/A",]
empleadores_empleos  <- empleadores_empleos [empleadores_empleos $`Tipo de Empleo`!="SE",]
empleadores_empleos <- empleadores_empleos[-4,]
mosaicplot(Empleador ~ `Tipo de Empleo`,data=empleadores_empleos ,color=c("#99cc99", "#cc9999", "#9999cc", "#9c9c9c", "lightskyblue2", "tomato"), las=1, main = " ")


#Empleos menos solicitados en base a fecha de publicacion
empleosXfecha <- data[,-1]
empleosXfecha <- empleosXfecha[,-1]
empleosXfecha[,1] = sapply(empleosXfecha[,1],as.character)
empleosXfecha[,1] = sapply(empleosXfecha[,1],as.numeric)
empleosXfecha[,2] = sapply(empleosXfecha[,2],as.character)
empleosXfecha <- empleosXfecha[empleosXfecha$Fecha>10,]
empleosXfecha <-empleosXfecha [complete.cases(empleosXfecha ),]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="SE",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="FINANCE,",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="RECEPCIONISTA.",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="CONTRATACIÓN...",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="CONTRATACIÓN",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="VACANTE",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="OFERTA",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="EMPLEO",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="URGENTE!!!",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="URGENTE",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="BACHILLER",]
empleosXfecha <- empleosXfecha[empleosXfecha$Empleo!="ASISTENTES",]
ggplot(empleosXfecha, aes(x=Fecha,y=Empleo)) + geom_point()


