class RatingPresenter < Jsonite
  property(:rating) { rating.to_f }
  property(:review) { review.try :review }
end
