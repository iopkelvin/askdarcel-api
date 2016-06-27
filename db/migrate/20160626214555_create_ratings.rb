class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.decimal :rating
      t.references :user, index: true, foreign_key: true
      t.references :resource, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true
    end
  end
end
