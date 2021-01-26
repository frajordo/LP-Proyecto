require 'open-uri'
require 'nokogiri'
require './empleo.rb'
require 'csv'

#csv = CSV.open('ofertas_computrabajo.csv', 'ab')
#csv << [nombre, nivel, tipo, institucion, imagen]

class Scraper_computrabajo

  def extraer(tema, lugar)
    page=1 
    ind = 0

    while(page<3)
      url= "https://www.computrabajo.com.ec/trabajo-de-#{tema}-en-#{lugar}?q=#{tema}&p=#{page}"
      web = open(url)
      data = web.read
      parsed_content = Nokogiri::HTML (data)
      inf_container = parsed_content.css('.bRS.bClick')
      inf_container.each do |node|
        puts "page #{page}************************************************"

        titulo = node.at_css('.js-o-link')
        titulo == nil ? titulo = "N/A" : titulo = titulo.inner_text

        empresa = node.at_css('.it-blank')
        empresa == nil ? empresa = "N/A" : empresa = empresa.inner_text.lstrip

        provincia = node.at_css('span[itemprop="addressRegion"]')
        provincia == nil ? provincia = "N/A" : provincia = provincia.inner_text

        tiempo_publicacion = node.at_css('.dO')
        tiempo_publicacion == nil ? tiempo_publicacion = "N/A" : tiempo_publicacion = tiempo_publicacion.inner_text

        puts "Fecha: #{tiempo_publicacion}"
        puts "Empresa: #{empresa}"
        puts "Direccion(ciudad, provincia): #{node.at_css('span[itemprop="addressLocality"]').inner_text}, #{provincia}"
        puts "trabajo: #{titulo}"
        
        curso = Empleo.new(titulo, empresa, "N/A", provincia, tiempo_publicacion, "N/A")

        csv = CSV.open('ofertas_computrabajo.csv', 'ab')
        csv << [titulo, empresa, "N/A", provincia, tiempo_publicacion, "N/A"]

        ind += 1
      end
      page+=1
    end
  end
end