
class Oferta

  #Constructor
  def initialize(job, company, location, brief, link, date)
    @job=job
    @company=company
    @location=location
    @brief=brief
    @link=link
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

  def getBrief
    @brief
  end

  def getCompany
    @company
  end

  def getLink
    @link
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

  def setBrief=(value)
    @brief=value
  end

  def setCompany=(value)
    @company=value
  end

  def setLink=(value)
    @link=value
  end

  def setLink=(value)
    @date=value
  end

end