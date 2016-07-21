class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource
  has_one :review

  validates :rating, numericality: {
    greater_than_or_equal_to: 1,
    less_than_or_equal_to: 5
  }
end
