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
    doc=Nokogiri::HTML(html.read)
    code=doc.css("ul.jobs")
    code=code.css("article.job.clicky")
    
    #puts code[0].css("a").first
    
    code.each do |desc|
      
      job=desc.css("a").first["title"]
      link=desc.css("a").first["href"]
      company=desc.search("p.company").text
      if company==""
        company="N/A"
      end
      location=desc.css("ul.details").text.strip
      date=desc.css("ul.tags").text.strip
      brief=desc.css("div.desc").text.strip
      oferta=Oferta.new(job, company, location, brief,link,date)
      array.append(oferta)
      #job=job.strip()
      #array.append(job)
      
      
      
    end
    self.registro(carrera,lugar,array)
    #puts array
    
  end

 def registro(carrera, lugar, array)
    CSV.open(carrera+"-"+lugar+".csv", "w") do |csv|
      csv << ["Trabajo","Empleador","Localizacion","Fecha","Link","Descripción"]
      array.each { |item|
        csv << [item.getJob, item.getCompany, item.getLocation,item.getDate ,item.getLink, item.getBrief]
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
