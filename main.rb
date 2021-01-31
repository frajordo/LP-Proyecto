require_relative "scraper.rb"
require "./Scraper_computrabajo.rb"
require "./scraper_empleo.rb"

# scrap=Scraper.new()
# scrap.extraer("", "Ecuador")

# sc = Scraper_computrabajo.new()
# sc.extraer(10)

scraper_empleo = ScraperEmpleo.new()
scraper_empleo.extraer("Ecuador")
