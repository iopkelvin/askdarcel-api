class CreateResourceImages < ActiveRecord::Migration
  def change
    create_table :resource_images do |t|
      t.belongs_to :resource, index: true, foreign_key: true
      t.string :caption

      t.timestamps null: false
    end
  end
end
