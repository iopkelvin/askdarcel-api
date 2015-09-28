class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.string :device_id, null: false
      t.belongs_to :resource, index: true, foreign_key: true, null: false
      t.belongs_to :rating_option, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :ratings, [:device_id, :resource_id], :unique => true
  end
end
