class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :page_id, :title, :email, :website, :summary, :content, :rating_counts, :my_rating

  has_many :phone_numbers
  has_many :categories
  has_many :addresses
  has_many :resource_images

  def rating_counts
    Hash[RatingOption.all.map do |option|
      [option.name, object.ratings.where(rating_option_id: option.id).count]
    end]
  end

  def my_rating
    rating = Rating.where(device_id: instance_options[:device_id], resource_id: object.id).first
    return nil unless rating

    ActiveModel::SerializableResource.new(rating).serializable_hash[:rating]
  end
end
