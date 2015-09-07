class ResourceSerializer < ActiveModel::Serializer
  attributes :id, :page_id, :title, :email, :website, :summary, :content

  has_many :phone_numbers
  has_many :categories
  has_many :addresses
end
