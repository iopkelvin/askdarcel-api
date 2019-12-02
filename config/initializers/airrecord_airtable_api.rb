# frozen_string_literal: true

if Rails.configuration.x.airtable.api_key
  Airrecord.api_key = Rails.configuration.x.airtable.api_key

  class AirTableOrgs < Airrecord::Table
    self.base_key = "appItSYNzRjTx08hN"
    self.table_name = "AskDarcel Organizations"

    # Update AirTable with a resource's 'name', 'status' & 'updated_at'
    def self.update_in_airtable(resource)
      airtable_orgs = self.all
      is_old_resource = 0
      airtable_orgs.each do |record|
        if record.fields["ID"] == resource.id
          record.fields["Organization Name" => resource.name,
                                "DB Status" => resource.status,
                       "Last Modified (DB)" => resource.updated_at]
          record.save
          is_old_resource = 1
        end
      end
      if is_old_resource.zero?
        self.create_in_airtable(resource)
      end
    end

    # Create new AirTable record if one wasn't there already
    def self.create_in_airtable(resource)
      self.create("ID" => resource.id,
           "Organization Name" => resource.name,
                   "DB Status" => resource.status,
          "Last Modified (DB)" => resource.updated_at,
             "Created At (DB)" => resource.created_at)
    end
  end
end
