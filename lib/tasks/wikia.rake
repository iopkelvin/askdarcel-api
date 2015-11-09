namespace :wikia do
  desc 'import wikia XML export'
  task import: :environment do
    ARGV.shift

    wikia_host = ENV['WIKIA_HOST'] || 'http://sfhomeless.wikia.com/'

    normalizer = Wikia::Normalizer.new(Rails.logger)
    Wikia::Parser.new(ARGF, Rails.logger).resources.each do |wikia_resource|
      ActiveRecord::Base.transaction do
        Resource.find_or_initialize_by(page_id: wikia_resource.page_id).tap do |r|
          next if r.revision_id == wikia_resource.revision_id.to_i

          normalized = normalizer.normalize_resource(wikia_resource)

          r.assign_attributes(
            revision_id: normalized.revision_id,
            title: normalized.title,
            email: normalized.email,
            summary: normalized.summary,
            content: normalized.content,
            website: normalized.website
          )
          r.categories = normalized.categories.map { |c| Category.find_or_create_by(name: c) }
          r.save!

          if normalized.phone
            r.phone_numbers.delete_all
            PhoneNumber.create!(
              resource: r,
              country_code: normalized.phone.country_code,
              area_code: normalized.phone.area_code,
              number: normalized.phone.number,
              extension: normalized.phone.extension
            )
          end

          if normalized.address
            r.addresses.delete_all
            Address.create!(
              resource: r,
              full_street_address: normalized.address.address,
              city: normalized.address.city,
              state: normalized.address.state,
              state_code: normalized.address.state_code,
              postal_code: normalized.address.postal_code,
              country: normalized.address.country,
              country_code: normalized.address.country_code,
              longitude: normalized.address.longitude,
              latitude: normalized.address.latitude
            )
          end

          r.resource_images.delete_all
          wikia_resource.images.each do |i|
            # Example image JSON:
            # {
            #  "query": {
            #    "pages": {
            #      "3097": {
            #        "pageid": 3097,
            #        "ns": 6,
            #        "title": "File:Providence from third street.jpg",
            #        "imagerepository": "local",
            #        "imageinfo": [
            #          {
            #            "url": "http://vignette3.wikia.nocookie.net/sfhomeless/images/6/67/Providence_from_third_street.jpg/revision/latest?cb=20090608220122",
            #            "descriptionurl": "http://sfhomeless.wikia.com/wiki/File:Providence_from_third_street.jpg"
            #          }
            #        ]
            #      }
            #    }
            #  }
            # }
            open("#{wikia_host}/api.php?action=query&titles=File:#{i.name}&prop=imageinfo&iiprop=url&format=json") do |f|
              data = JSON.parse(f.read)
              urls =  data['query']['pages'].map do |id, page|
                if id == '-1'
                  Rails.logger.warn("photo missing for page #{r.page_id} with name #{i.name}")
                  next
                end

                page['imageinfo'].map { |i| i['url'] }
              end.flatten.reject(&:blank?)

              urls.map do |url|
                ResourceImage.create!(resource: r, caption: i.caption, photo: open(url))
              end
            end
          end
        end
      end
    end
  end
end
