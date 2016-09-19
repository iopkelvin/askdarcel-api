class AddUniqueIndexOnRatingsUserId < ActiveRecord::Migration
  def change
    remove_index :ratings, :user_id
    add_index :ratings, [:user_id, :resource_id], unique: true
    add_index :ratings, [:user_id, :service_id], unique: true
    add_index :ratings, [:user_id, :resource_id, :service_id], unique: true
  end
end
