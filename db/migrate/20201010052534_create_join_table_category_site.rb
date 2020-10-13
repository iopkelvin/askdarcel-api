class CreateJoinTableCategorySite < ActiveRecord::Migration[5.2]
  def change
    create_join_table :categories, :sites do |t|
      t.references :category, index:true, foreign_key: true, null: false
      t.references :site, index:true, foreign_key: true, null: false
    end
  end
end
