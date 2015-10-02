class RatingSerializer < ActiveModel::Serializer
  attributes :id, :device_id, :resource_id, :rating_option_name

  def rating_option_name
    object.rating_option.name
  end
end
