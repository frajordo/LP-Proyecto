#require 'open-uri'
require 'nokogiri'
require './empleo.rb'
require 'csv'

#csv = CSV.open('ofertas_computrabajo.csv', 'ab')
#csv << [nombre, nivel, tipo, institucion, imagen]

class Scraper_computrabajo
  ACTUAL_SECONDS = Time.new.to_i

  def extraer(paginas)
    page=1 
    ind = 0
    paginas <=0 ? paginas = 2 : paginas = paginas
    meses = ["x", "enero", "febrero", "marzo", "abril", "mayo", "junio", "julio", "agosto", "septiembre", "octubre", "noviembre", "diciembre" ]
    mesActual = 0
    anioACTUAL =2021

    while(page<= paginas)
      url= "https://www.computrabajo.com.ec/ofertas-de-trabajo/?p=#{page}"
      web = URI.open(url)
      data = web.read
      parsed_content = Nokogiri::HTML (data)
      inf_container = parsed_content.css('.bRS.bClick')
      inf_container.each do |node|

        trabajo = node.at_css('.js-o-link')
        trabajo == nil ? trabajo = "N/A" : trabajo = trabajo.inner_text

        empleador = node.at_css('.it-blank')
        empleador == nil ? empleador = "N/A" : empleador = empleador.inner_text.lstrip
        if empleador=="" or empleador=='""'
          empleador="N/A"
        end

        ciudad = node.at_css('span[itemprop="addressLocality"]')
        ciudad == nil ? ciudad = "N/A" : ciudad = ciudad.inner_text

        descripcion = node.at_css('p')
        descripcion == nil ? descripcion = "N/A" : descripcion = descripcion.inner_text.lstrip

        tiempo_publicacion = node.at_css('.dO')
        tiempo_publicacion == nil ? tiempo_publicacion = "N/A" : tiempo_publicacion = tiempo_publicacion.inner_text
        
        if tiempo_publicacion.include? "Hoy"
          tiempo_publicacion = "0"
        elsif tiempo_publicacion.include? "Ayer"
          tiempo_publicacion = "1"
        else
          if mesActual == 1 and meses.index(tiempo_publicacion.split()[1]) == 12
            anioACTUAL = anioACTUAL -1
          end

          diaActual = tiempo_publicacion.split()[0].to_i
          mesActual = meses.index(tiempo_publicacion.split()[1])

          fechaPublicacion = Time.new(anioACTUAL, mesActual, diaActual)
          dias_publicacion =  ( ACTUAL_SECONDS - fechaPublicacion.to_i ) / 86400
          tiempo_publicacion = "#{dias_publicacion}"
        end
        

        csv = CSV.open("-Ecuador.csv", 'ab',encoding: "utf-8")
        csv << [trabajo, empleador, provincia, tiempo_publicacion]

        ind += 1
      end
      page+=1
    end
    puts "datos extraido de computrabajo exitosamente"
  end
end