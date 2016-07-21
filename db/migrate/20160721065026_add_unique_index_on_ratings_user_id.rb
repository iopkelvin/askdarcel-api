class AddUniqueIndexOnRatingsUserId < ActiveRecord::Migration
  def change
    remove_index :ratings, :user_id
    add_index :ratings, :user_id, unique: true
  end
end
