
class Oferta

  #Constructor
  def initialize(job, company, location, date)
    @job=job
    @company=company
    @location=location
    @date=date
  end

  #Accessor
  def getJob
    @job
  end

  def getCompany
    @company
  end

  def getLocation
    @location
  end

  def getDate
    @date
  end

  #Setter

  def setJob=(value)
    @job=value
  end

  def setCompany=(value)
    @company=value
  end

  def setLocation=(value)
    @location=value
  end


  def setDate=(value)
    @date=value
  end

end