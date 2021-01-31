class Empleo
    attr_accessor :trabajo, :empleador, :localizacion, :tiempo_publicacion 
  
    def initialize(trabajo, empleador, localizacion, tiempo_publicacion)
      @trabajo = trabajo
      @empleador = empleador
      @localizacion = localizacion
      @tiempo_publicacion = tiempo_publicacion
    end
  
    # def imprimir()
    #   return @titulo+", "+@empresa+","+@salario+","+@provincia+","+@tiempo_publicacion+","+@mision
    # end 

end