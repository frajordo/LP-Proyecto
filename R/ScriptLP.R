#Proyecto LP
install.packages("randomcoloR")
library("randomcoloR")
setwd(dirname(rstudioapi::getSourceEditorContext()$path))
datos=read.csv("../-Ecuador.csv")

#�Qu� empresas/empleadores ofrecen m�s empleo?
empleadores=table(datos$Empleador)
emplSorted=sort(empleadores,decreasing=TRUE)
#Gr�fica de los 10 empleadores con m�s ofertas en todo el ecuador
barplot(emplSorted[1:10],legend=TRUE, col = distinctColorPalette(10))
#Gr�fica de los 10 empleadores con m�s ofertas en todo el ecuador sin contar a los N/A
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



#�Cu�les son los empleos menos solicitados? 
#table(datos$Trabajo)

#table(firstletter)



#�Qu� provincia tiene menor oferta laboral y cuales son esos empleos? 
  


install.packages("dplyr")
install.packages("tidyr")
install.packages("readxl")
install.packages("ggplot2")
library (ggplot2)
#---¿Cuál es la provincia con mayor oferta laboral en Ecuador?
data <- read.csv('../-Ecuador.csv')
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


#----¿Qué carreras son las más buscadas en cada provincia?
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




