class AddUniqueIndexOnReviewsRatingId < ActiveRecord::Migration
  def change
    remove_index :reviews, :rating_id
    add_index :reviews, :rating_id, unique: true
  end
end
