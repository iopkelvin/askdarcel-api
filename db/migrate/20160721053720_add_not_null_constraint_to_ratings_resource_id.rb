class AddNotNullConstraintToRatingsResourceId < ActiveRecord::Migration
  def change
    change_column :ratings, :resource_id, :integer, null: false
  end
end
