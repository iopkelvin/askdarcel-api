class CreateJoinTableResourcesSites < ActiveRecord::Migration[5.2]
  def change
    create_join_table :sites, :resources do |t|
      t.references :site, index: true, foreign_key: true, null: false
      t.references :resource, index: true, foreign_key: true, null: false
    end
  end
end
