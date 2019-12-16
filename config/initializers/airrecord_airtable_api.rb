# frozen_string_literal: true

if Rails.configuration.x.airtable.api_key
  Airrecord.api_key = Rails.configuration.x.airtable.api_key

  class AirTableOrgs < Airrecord::Table
    self.base_key = "appItSYNzRjTx08hN"
    self.table_name = "AskDarcel Organizations"

    def self.create_resource(resource)
      create("ID" => resource.id,
             "Organization Name" => resource.name,
             "DB Status" => resource.status,
             "Last Modified (DB)" => resource.updated_at,
             "Created At (DB)" => resource.created_at)
    end

    def self.update_resource(resource)
      all(filter: "{ID} = " + resource.id.to_s)
        .find(&:first.id)
        .update("Organization Name" => resource.name,
                "DB Status" => resource.status,
                "Last Modified (DB)" => resource.updated_at)
        .save
    end
  end
end
