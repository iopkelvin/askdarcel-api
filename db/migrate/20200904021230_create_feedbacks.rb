class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.integer :rating, null: false
      t.text :review
      t.belongs_to :reviewable, polymorphic: true

      t.timestamps
    end
  end
end
