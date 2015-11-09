namespace :bulk do
  # export to CSV (may not be up-to-date, not sure if we'll want this functionality long term)
  task export: :environment do
    Rails.logger.level = 1
    csv = CSV.new(STDOUT)
    Resource.all.each do |r|
      row = [
        r.id,
        r.title,
        r.addresses.first.try(:full_street_address),
        r.phone_numbers.first.try { |pn| "(#{pn.area_code}) #{pn.number}" },
        r.resource_images.map(&:photo).map(&:url).join(';'),
        r.website,
        r.summary,
        r.content,
        "http://sfhomeless.wikia.com/wiki/#{URI.escape(r.title)}"
      ]

      csv << row

      STDOUT.flush
    end
  end

  task import: :environment do
    ARGV.shift
    Rails.logger.level = 1
    CSV.new(ARGF, headers: :first_row).each do |row|
      case (row['Done'] || '').upcase.strip
      when ''
        puts "deleting incomplete #{row.fetch('ID')}"
        Resource.find_by_id(row.fetch('ID')).try(:destroy)
        next
      when 'DELETE'
        puts "deleting #{row.fetch('ID')}"
        Resource.find_by_id(row.fetch('ID')).try(:destroy)
      when 'X'
        puts "updating #{row.fetch('ID')}"
        update_resource(row)
      else
        puts "unknown 'Done' value: #{row.fetch('Done')} for #{row.fetch('ID')}"
      end
    end
  end

  CATEGORIES = %w(Eats Shelter Facilities Health Employment Legal Assistance Education)

  def update_resource(row)
    point_factory = RGeo::ActiveRecord::SpatialFactoryStore.instance.factory(geo_type: 'point')

    resource = if row.fetch('ID').blank?
                 Resource.find_or_create_by(title: row.fetch('Title'))
               else
                 Resource.find(row.fetch('ID'))
               end

    resource.assign_attributes(
      title: row.fetch('Title'),
      summary: row.fetch('Summary'),
      content: '',
      website: row.fetch('Website')
    )

    resource.save!

    id = resource.reload.id

    unless row.fetch('Address').blank?
      address = Geocoder.search(row.fetch('Address')).first
      if address
        resource.addresses.delete_all
        Address.create!(
          resource: resource,
          full_street_address: address.address,
          city: address.city,
          state: address.state,
          state_code: address.state_code,
          postal_code: address.postal_code,
          country: address.country,
          country_code: address.country_code,
          lonlat: point_factory.point(address.longitude, address.latitude)
        )
      else
        puts "could not geocode address #{row.fetch('Address')} for #{id}"
      end
    end

    unless row['Phone number'].blank?
      phone = Phoner::Phone.parse(row.fetch('Phone number'), country_code: '1')
      if phone
        resource.phone_numbers.delete_all
        PhoneNumber.create!(
          resource: resource,
          country_code: phone.country_code,
          area_code: phone.area_code,
          number: phone.number,
          extension: phone.extension
        )
      else
        puts "could not normalize phone #{row['Phone number']} for #{id}"
      end
    end

    resource.resource_images.delete_all
    (row.fetch('Photos') || '').split(';').each do |url|
      begin
        ResourceImage.create!(resource: resource, photo: open(url.strip))
      rescue ActiveRecord::RecordInvalid
        puts "invalid photo #{url} for #{id}"
      end
    end

    resource.categories = CATEGORIES.select { |v| !row.fetch(v).blank? }.map { |c| Category.find_or_create_by(name: c) }
  end
end
