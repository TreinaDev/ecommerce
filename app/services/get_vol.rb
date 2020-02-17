class GetVol
  attr_accessor :height, :width, :thickness

  def initialize(height, width, thickness)
    @height = height
    @width = width
    @thickness = thickness
  end



  def self.total(height, width, thickness)
    vol = (width/1000) * (height/1000) * (thickness/1000)
    vol
  end
end
