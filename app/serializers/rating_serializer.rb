class RatingSerializer < ActiveModel::Serializer
  attributes :id, :device_id, :resource_id
  has_one :rating_option
end
