class Resource < ActiveRecord::Base
  default_scope -> { order('id') }

  has_many :categories, through: :categories_resources
  has_many :categories_resources, dependent: :destroy

  has_many :phone_numbers, dependent: :destroy
  has_many :addresses, dependent: :destroy
  has_many :resource_images, dependent: :destroy
  has_many :ratings, dependent: :destroy
end
