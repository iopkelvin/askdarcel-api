class CreateFeedbacks < ActiveRecord::Migration[5.2]
  def change
    create_table :feedbacks do |t|
      t.boolean :rating, null: false
      t.text :review
      t.text :tags, array: true, default: []
      t.references :resource, index: true, foreign_key: true
      t.references :service, index: true, foreign_key: true

      t.timestamps
    end
  end
end
