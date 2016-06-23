class Resource < ActiveRecord::Base
  has_and_belongs_to_many :categories
  has_one :address
  has_many :phones
  has_one :schedule
  has_many :notes
  has_many :services
end
