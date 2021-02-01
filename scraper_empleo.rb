require 'nokogiri'
require 'csv'
require_relative "empleo.rb"

def registrar_CSV(empleos)
  CSV.open('-Ecuador.csv', 'ab',encoding: "utf-8") do |csv|
    empleos.each { |empleo|
     csv << [empleo.trabajo, empleo.empleador, empleo.localizacion, empleo.tiempo_publicacion]
    }
  end
end

class ScraperEmpleo
  @@pagina = 1
  @@empleos = []

  def extraer(ubicacion)
    url = "https://ec.jooble.org/SearchResult?p=#{@@pagina}&rgns=#{ubicacion}"
    if @@pagina < 9
      courseraHTML = URI.open(url)
      parsed_content = Nokogiri::HTML(courseraHTML)
      unorder_list = parsed_content.css('._70404 div')
      unorder_list.css('._31572').each do |trabajos|
        titulo = trabajos.css('._84af9').css('._1e859').css('.baa11 ._4ef07').css('.a7df9').css('span').inner_text[0..-1]
        tamano = (titulo.length/2)-1
        titulo = titulo[0..tamano]

        seccion = trabajos.css('._77886')
        empresa = seccion.css('.f388a div').css('.companyInfo__link .caption').inner_text[0..-1]
        # descripcion = seccion.css('._0b1c1').inner_text[0..-1]
        if empresa == ""
          empresa = "N/A"
        end
        lugar = nil
        tiempo_publicacion = nil
        seccion.css('._77a3a .caption').each do |infos|
          string = infos.inner_text[0..-1]
          if string != empresa
            if lugar == nil
              lugar = string
            else
              tiempo_publicacion = string.split(" ")
              dias = tiempo_publicacion[1]
              if dias == "horas" or dias == "hora"
                tiempo_publicacion = "0"
              else
                tiempo_publicacion = tiempo_publicacion[0]
              end
            end
          end
        end
        if lugar.include?(",")
          localizacion = lugar.split(",")
          lugar = localizacion[0]     
        end   
        trabajo = Empleo.new(titulo, empresa, lugar, tiempo_publicacion)
        @@empleos.append(trabajo)   
      end
      @@pagina = @@pagina + 1
      extraer(ubicacion)
    else
      @@pagina = 1
      self.registrar_CSV(@@empleos)
    end
  end
end