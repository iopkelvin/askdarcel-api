class CreatePhoneNumbers < ActiveRecord::Migration
  def change
    create_table :phone_numbers do |t|
      t.integer :country_code
      t.integer :area_code
      t.integer :number
      t.integer :extension
      t.text :comment
      t.belongs_to :resource, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
