class CreateJoinTableResourceKeyword < ActiveRecord::Migration
  def change
    create_join_table :resources, :keywords do |t|
      # t.index [:resource_id, :keyword_id]
      # t.index [:keyword_id, :resource_id]
    end
  end
end
