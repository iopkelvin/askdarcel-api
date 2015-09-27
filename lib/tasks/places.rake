namespace :places do
  # Quick and dirty for a research spike
  desc "export resources with associated google place results"
  task export: :environment do
    Rails.logger.level = 1

    google_api_key = ENV['GOOGLE_API_TOKEN']

    nearby_search_template = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=37.7833,-122.4167&radius=5000&&name=%s&key=#{google_api_key}"
    details_search_template = "https://maps.googleapis.com/maps/api/place/details/json?placeid=%s&key=#{google_api_key}"

    csv = CSV.new(STDOUT)
    Resource.all.each do |r|
      row = [
        r.title,
        r.addresses.first.try(:full_street_address),
        r.phone_numbers.first.try { |pn| "(#{pn.area_code}) #{pn.number}" },
        nil,
        r.resource_images.count,
        r.website,
        "http://sfhomeless.wikia.com/wiki/#{URI.escape(r.title)}",
      ]

      response = Faraday.get(nearby_search_template % URI.escape(r.title))
      list = JSON.parse(response.body)

      case list['status']
      when 'ZERO_RESULTS'
      when 'OK'
        response = Faraday.get(details_search_template % list['results'][0]['place_id'])
        details = JSON.parse(response.body)['result']

        row.concat([
          details['name'],
          details['formatted_address'],
          details['formatted_phone_number'],
          details.key?('opening_hours') ? 'yes' : nil,
          details.fetch('photos', []).length,
          details['website'],
          details['url'],
        ])
      else
        STDERR.puts response.body
        raise "error: #{list['status']}"
      end

      csv << row

      STDOUT.flush
    end
  end
end
