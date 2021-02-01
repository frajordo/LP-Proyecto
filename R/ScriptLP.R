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

#table(firstletter)



#¿Qué provincia tiene menor oferta laboral y cuales son esos empleos? 
  







