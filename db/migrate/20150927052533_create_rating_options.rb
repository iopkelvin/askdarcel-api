class CreateRatingOptions < ActiveRecord::Migration
  def change
    create_table :rating_options do |t|
      t.string :name, null: false

      t.timestamps null: false
    end
    add_index :rating_options, :name, unique: true
  end
end
