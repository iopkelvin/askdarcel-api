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
    puts 'TODO'
  end
end
