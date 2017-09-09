class AddTopLevelToCategories < ActiveRecord::Migration[5.0]
  def change
    add_column :categories, :top_level, :boolean, index: true, null: false, default: true
    change_column_default :categories, :top_level, from: true, to: false
  end
end
