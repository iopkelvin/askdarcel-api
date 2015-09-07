class Address < ActiveRecord::Base
  belongs_to :resource

  def longitude
    lonlat.y
  end

  def latitude
    lonlat.x
  end
end
