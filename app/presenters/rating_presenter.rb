class RatingPresenter < Jsonite
  property :user, with: UserPresenter
  property(:rating) { rating.to_f }
  property(:review) { review.try :review }
end
