class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.belongs_to :resource, index: true, foreign_key: true
      t.string :full_street_address
      t.string :city
      t.string :state
      t.string :state_code
      t.string :postal_code
      t.string :country
      t.string :country_code
      t.st_point :lonlat, geographic: true, srid: 4326

      t.timestamps null: false
    end
  end
end
