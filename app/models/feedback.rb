class Feedback < ApplicationRecord
    validates :rating, presence: true
    belongs_to :feedbackable, polymorphic: true
end
