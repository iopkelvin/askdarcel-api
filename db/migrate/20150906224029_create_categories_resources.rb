class CreateCategoriesResources < ActiveRecord::Migration
  def change
    create_table :categories_resources do |t|
      t.references :resource, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
