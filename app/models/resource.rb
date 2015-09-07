class Resource < ActiveRecord::Base
  default_scope ->{ order('id') }

  has_many :phone_numbers
  has_many :categories, through: :categories_resources
  has_many :categories_resources
  has_many :addresses
end
