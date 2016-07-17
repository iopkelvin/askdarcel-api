class RatingsPresenter < Jsonite
  property :rating
  property :review, with: ReviewsPresenter
end