class CreateJoinTableResourceSite < ActiveRecord::Migration[5.2]
  def change
    create_join_table :resources, :sites do |t|
      t.references :site, index:true, foreign_key: true, null: false
      t.references :resource, index:true, foreign_key: true, null: false
    end
  end
end
