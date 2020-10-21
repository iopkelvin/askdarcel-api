# frozen_string_literal: true

class Site < ActiveRecord::Base
  has_and_belongs_to_many :resources
  has_and_belongs_to_many :categories  
end
