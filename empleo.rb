class Empleo
    attr_accessor :trabajo, :empleador, :localizacion, :tiempo_publicacion, :descripcion 
  
    def initialize(trabajo, empleador, localizacion, tiempo_publicacion, descripcion)
      @trabajo = trabajo
      @empleador = empleador
      @localizacion = localizacion
      @tiempo_publicacion = tiempo_publicacion
      @descripcion = descripcion  
    end
  
    # def imprimir()
    #   return @titulo+", "+@empresa+","+@salario+","+@provincia+","+@tiempo_publicacion+","+@mision
    # end 

end