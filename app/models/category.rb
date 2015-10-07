class Category < ActiveRecord::Base
  default_scope -> { order('id') }

  has_many :resources, through: :categories_resources
  has_many :categories_resources
end
