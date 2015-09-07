class PhoneNumberSerializer < ActiveModel::Serializer
  attributes :id, :country_code, :area_code, :number, :extension, :comment

  belongs_to :resource
end
