namespace :wikia do
  desc "import wikia XML export"
  task import: :environment do
    ARGV.shift

    normalizer = Wikia::Normalizer.new(Rails.logger)
    Wikia::Parser.new(ARGF, Rails.logger).resources.each do |resource|
      Resource.find_or_initialize_by(page_id: resource.page_id).tap do |r|
        next if r.revision_id == resource.revision_id.to_i

        normalized = normalizer.normalize_resource(r)

        r.assign_attributes(
          revision_id: normalized.revision_id,
          title: normalized.title,
          email: normalized.email,
          summary: normalized.summary,
          content: normalized.content,
          website: normalized.website,
        )
        r.categories = normalized.categories.map { |c| Category.find_or_create_by(name: c) }
        r.save!

        if normalized.phone
          r.phone_numbers.delete_all
          PhoneNumber.find_or_create_by!(
            resource: r,
            country_code: normalized.phone.country_code,
            area_code: normalized.phone.area_code,
            number: normalized.phone.number,
            extension: normalized.phone.extension
          )
        end

        if normalized.address
          r.addresses.delete_all
          Address.find_or_create_by!(
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
      end
    end
  end
end
