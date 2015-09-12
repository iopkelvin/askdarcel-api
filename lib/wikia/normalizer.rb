require 'phone'

module Wikia
  class Normalizer
    class Resource < Struct.new(:page_id, :revision_id, :title, :address, :phone, :email, :website, :contacts, :hours, :languages, :summary, :content, :categories, :images)
    end

    class Image < Struct.new(:name, :caption, :url)
    end

    attr_reader :logger

    def initialize(logger)
      @logger = logger
    end

    def normalize_resource(resource)
      ResourceNormalizer.new(resource, logger).execute()
    end

    private

    class ResourceNormalizer
      attr_reader :resource, :logger

      def initialize(resource, logger)
        @resource = resource
        @logger = logger
      end

      def execute()
        resource_hash = {
          page_id: resource.page_id,
          revision_id: resource.revision_id,
          title: resource.title,
          address: normalize_address(resource.address),
          phone: normalize_phone_number(resource.phone),
          email: resource.email,
          website: resource.website,
          contacts: resource.contacts,
          hours: resource.hours,
          languages: resource.languages,
          summary: resource.summary,
          content: resource.content,
          categories: resource.categories,
          images: resource.images.map { |i| normalize_image(i) },
        }
        Resource.new(*resource_hash.values_at(*Resource.members))
      end

      def normalize_address(address)
        return nil unless address.to_s.strip.length > 0

        Geocoder.search(address).first
      end

      def normalize_image(image)
        
      end

      def normalize_phone_number(phone)
        return nil unless phone.to_s.strip.length > 0
        #TODO ask about handling of multiple phone numbers
        Phoner::Phone.parse(phone, country_code: '1').tap do |pn|
          @logger.warn("#{resource.page_id}: could not parse #{phone} as a phone number") unless pn
        end
      rescue Phoner::AreaCodeError
        @logger.warn("#{resource.page_id}: #{phone} missing area code)")
      end
    end
  end
end
