class Address < ActiveRecord::Base
  belongs_to :resource

  geocoded_by :address do |obj,results|
    if geo = results.first
      obj.lonlat = POINT_FACTORY.point(geo.longitude, geo.latitude)
    end
  end

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.full_street_address = geo.address
      obj.state_code = geo.state_code
      obj.country_code = geo.country_code
    end
  end
  after_validation :geocode, :reverse_geocode

  def longitude
    lonlat.y
  end

  def latitude
    lonlat.x
  end

  private

  def address
      [street1, street2, city, state, country].compact.join(', ')
  end

  POINT_FACTORY = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(geo_type: "point")
end
