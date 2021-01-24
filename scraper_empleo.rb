require 'open-uri'
require 'nokogiri'
require 'csv'
require_relative "empleo.rb"

def registrar_CSV(file, empleos)
  CSV.open(file, 'a') do |csv|
    csv << ["Trabajo","Empleador","Salario","Localizacion","Fecha","Descripción"]
    empleos.each { |empleo|
    csv << [empleo.titulo, empleo.empresa, empleo.salario, empleo.provincia, empleo.tiempo_publicacion, empleo.mision]
    }
  end
end

class ScraperEmpleo
  def extraer(ubicacion)
    empleos = []
    url = "https://ec.jooble.org/SearchResult?p=1&rgns=#{ubicacion}"
    courseraHTML = open(url)
    parsed_content = Nokogiri::HTML(courseraHTML)
    unorder_list = parsed_content.css('._70404 div')
    unorder_list.css('._31572').each do |trabajos|
      titulo = trabajos.css('._84af9').css('._1e859').css('.baa11 ._4ef07').css('.a7df9').css('span').inner_text[0..-1]
      tamano = (titulo.length/2)-1
      titulo = titulo[0..tamano]
      seccion = trabajos.css('._77886')
      salario = seccion.css('._29fd5 span').inner_text[0..2]
      empresa = seccion.css('.f388a div').css('.companyInfo__link .caption').inner_text[0..-1]
      mision = seccion.css('._0b1c1').inner_text[0..-1]
      if salario == ""
        salario = "N/A"
      elsif empresa == ""
        empresa = "N/A"
      elsif mision == ""
        mision = seccion.css('._0b1c1 span').inner_text[0..-1]
      end
      lugar = nil
      tiempo_publicacion = nil
      seccion.css('._77a3a .caption').each do |infos|
        string = infos.inner_text[0..-1]
        if string != empresa
          if lugar == nil
            lugar = string
          else
            tiempo_publicacion = string
          end
        end
      end        
      trabajo = Empleo.new(titulo, empresa, salario, lugar, tiempo_publicacion, mision)
      trabajo.imprimir()
      empleos.append(trabajo)      
    end
    self.registrar_CSV("Trabajos-"+ ubicacion + '.csv', empleos)
  end
end

