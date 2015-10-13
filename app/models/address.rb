class Address < ActiveRecord::Base
  belongs_to :resource

  def longitude
    lonlat.x
  end

  def latitude
    lonlat.y
  end
end
