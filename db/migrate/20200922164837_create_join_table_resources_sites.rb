class CreateJoinTableResourcesSites < ActiveRecord::Migration[5.2]
  def change
    create_join_table :resources, :sites do |t|
      # t.index [:resource_id, :site_id]
      # t.index [:site_id, :resource_id]
    end
  end
end
