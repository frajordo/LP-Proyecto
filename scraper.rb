require "nokogiri"
require "open-uri"
require "csv"
require_relative "oferta.rb"

class Scraper

  def initialize
  end

  def extraer(carrera,lugar)
    array=[]
    #carrera[" "]="+"
    html=URI.open("https://www.opcionempleo.ec/buscar/empleos?s="+carrera+"&l="+lugar+"&radius=10&sort=relevance")
    for i in 0..9
      doc=Nokogiri::HTML(html.read)
      code=doc.css("ul.jobs")
      code=code.css("article.job.clicky")
      x=doc.css("p.more").css("a").first["href"]
      
      #puts code[0].css("a").first
      
      code.each do |desc|
        
        job=desc.css("a").first["title"]
        link=desc.css("a").first["href"]
        company=desc.search("p.company").text
        if company==""
          company="N/A"
        end
        location=desc.css("ul.details").css("li").first.text.strip
        date=desc.css("ul.tags").css("li").first.text.strip
        if date.include? "horas"
          date="0"
        elsif date.include? "días" or date.include? "día"
          date=date.scan(/\d/).join("")
        elsif date.include? "mes"
          date=date.scan(/\d/).join("")
          date=date.to_i * 30
          date=date.to_s
        end
        brief=desc.css("div.desc").text.strip
        oferta=Oferta.new(job, company, location, brief,link,date)
        array.append(oferta)
        #job=job.strip()
        #array.append(job)
        
      end
      html=URI.open("https://www.opcionempleo.ec"+x)

    end
    self.registro(carrera,lugar,array)
    #puts array
    
  end

 def registro(carrera, lugar, array)
    CSV.open(carrera+"-"+lugar+".csv", "w",encoding: "utf-8") do |csv|
      csv << ["Trabajo","Empleador","Localizacion","Fecha","Descripción"]
      array.each { |item|
        csv << [item.getJob, item.getCompany, item.getLocation,item.getDate , item.getBrief]
      }
    end
  end

  def registroprueba(carrera, lugar, array)
    CSV.open(carrera+"-"+lugar+".csv", "w") do |csv|
      array.each do |item|
        csv << [item]
        puts item
      end
    end
  end

end
