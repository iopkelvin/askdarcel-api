# frozen_string_literal: true

class Feedback < ApplicationRecord
  validates :rating, presence: true
  belongs_to :reviewable, polymorphic: true
end
