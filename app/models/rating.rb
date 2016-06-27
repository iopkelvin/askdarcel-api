class Rating < ActiveRecord::Base
  belongs_to :user
  belongs_to :resource
  belongs_to :service
  has_one :review
end