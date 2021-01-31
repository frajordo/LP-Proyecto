#require 'open-uri'
require 'nokogiri'
require './empleo.rb'
require 'csv'

#csv = CSV.open('ofertas_computrabajo.csv', 'ab')
#csv << [nombre, nivel, tipo, institucion, imagen]

class Scraper_computrabajo

  def extraer(paginas)
    page=1 
    ind = 0
    paginas <=0 ? paginas = 2 : paginas = paginas

    while(page<= paginas)
      url= "https://www.computrabajo.com.ec/ofertas-de-trabajo/?p=#{page}"
      web = URI.open(url)
      data = web.read
      parsed_content = Nokogiri::HTML (data)
      inf_container = parsed_content.css('.bRS.bClick')
      inf_container.each do |node|
        puts "page #{page}************************************************"

        trabajo = node.at_css('.js-o-link')
        trabajo == nil ? trabajo = "N/A" : trabajo = trabajo.inner_text

        empleador = node.at_css('.it-blank')
        empleador == nil ? empleador = "N/A" : empleador = empleador.inner_text.lstrip

        provincia = node.at_css('span[itemprop="addressRegion"]')
        provincia == nil ? provincia = "N/A" : provincia = provincia.inner_text

        descripcion = node.at_css('p')
        descripcion == nil ? descripcion = "N/A" : descripcion = descripcion.inner_text.lstrip

        #t = Time.at(628232400)
        #puts "tiempos:   #{t.to_i }  "
        random = Random.new

        tiempo_publicacion = node.at_css('.dO')
        tiempo_publicacion == nil ? tiempo_publicacion = "N/A" : tiempo_publicacion = tiempo_publicacion.inner_text
        
        if tiempo_publicacion.include? "Hoy"
          tiempo_publicacion = "0"
        elsif tiempo_publicacion.include? "Ayer"
          tiempo_publicacion = "1"
        else
          tiempo_publicacion = "#{random.rand(3..200)}"
        end
        
        csv = CSV.open("-Ecuador.csv", 'ab')
        csv << [trabajo, empleador, provincia, tiempo_publicacion, descripcion]

        ind += 1
      end
      page+=1
    end
  end
end