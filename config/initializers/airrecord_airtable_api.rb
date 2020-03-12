# frozen_string_literal: true

if Rails.configuration.x.airtable.api_key
  Airrecord.api_key = Rails.configuration.x.airtable.api_key

  class AirTableOrgs < Airrecord::Table
    self.base_key = ENV['AIRTABLE_BASE_KEY']
    self.table_name = ENV['AIRTABLE_TABLE_NAME']
  end
end
