class Empleo
    attr_accessor :titulo, :empresa, :salario, :provincia, :tiempo_publicacion, :mision 
  
    def initialize(titulo, empresa, salario, provincia, tiempo_publicacion, mision)
      @titulo = titulo
      @empresa = empresa
      @salario = salario
      @provincia = provincia
      @tiempo_publicacion = tiempo_publicacion
      @mision = mision  
    end
  
    # def imprimir()
    #   return @titulo+", "+@empresa+","+@salario+","+@provincia+","+@tiempo_publicacion+","+@mision
    # end 

end