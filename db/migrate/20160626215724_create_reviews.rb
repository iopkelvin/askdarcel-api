class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.text :review
      t.references :rating, index: true, foreign_key: true
    end
  end
end
