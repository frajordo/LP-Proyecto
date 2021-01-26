require_relative "scraper.rb"
require "./Scraper_computrabajo.rb"

scrap=Scraper.new()
#scrap.extraer("Arquitecto", "Ecuador")

sc = Scraper_computrabajo.new()
sc.extraer("auxiliar", "ecuador")