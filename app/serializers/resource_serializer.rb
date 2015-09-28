class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :page_id, :title, :email, :website, :summary, :content, :rating_counts

  has_many :phone_numbers
  has_many :categories
  has_many :addresses
  has_many :resource_images

  def rating_counts
    Hash[RatingOption.all.map do |option|
      [option.name, object.ratings.where(rating_option_id: option.id).count]
    end]
  end
end
