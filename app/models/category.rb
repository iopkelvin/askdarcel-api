class Category < ActiveRecord::Base
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :services
end
