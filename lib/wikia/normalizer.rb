require 'phone'

module Wikia
  class Normalizer
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
        {
          page_id: resource.page_id,
          title: resource.title,
          address: resource.address,
          phone: resource.phone,
          email: resource.email,
          website: resource.website,
          contacts: resource.contacts,
          hours: resource.hours,
          languages: resource.languages,
          summary_text: resource.summary_text,
          text: ""
        }
      end

      def normalize_phone_number(phone)
        return nil unless phone.to_s.strip.length > 0

        #TODO ask about handling of multiple phone numbers
        Phoner::Phone.parse(phone, country_code: '1').tap do |pn|
          @logger.warn("#{resource.id}: could not parse #{phone} as a phone number") unless pn
        end
      rescue Phoner::AreaCodeError
        @logger.warn("#{phone} missing area code)")
      end
    end

  end
end
