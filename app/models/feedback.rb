# frozen_string_literal: true

class Feedback < ApplicationRecord
  validates :rating, presence: true
  belongs_to :resource
  belongs_to :service
end
