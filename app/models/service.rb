class Service < ActiveRecord::Base
  belongs_to :resource
  has_many :notes
  has_one :schedule
  has_and_belongs_to_many :categories
  has_many :ratings
end
