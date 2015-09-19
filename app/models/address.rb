class Address < ActiveRecord::Base
  belongs_to :resource

  geocoded_by :address
  reverse_geocoded_by :latitude, :longitude
  after_validation :geocode, :reverse_geocode

  reverse_geocoded_by :latitude, :longitude do |obj,results|
    if geo = results.first
      obj.full_street_address = geo.address
      obj.state_code = geo.state_code
      obj.country_code = geo.country_code
    end
  end

  private

  def address
      [street1, street2, city, state, country].compact.join(', ')
  end
end
