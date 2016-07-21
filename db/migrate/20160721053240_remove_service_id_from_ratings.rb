class RemoveServiceIdFromRatings < ActiveRecord::Migration
  def change
    remove_column :ratings, :service_id, :integer
  end
end
