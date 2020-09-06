class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.integer :rating
      t.text :review
      t.belongs_to :feedbackable, polymorphic: true

      t.timestamps
    end
  end
end
