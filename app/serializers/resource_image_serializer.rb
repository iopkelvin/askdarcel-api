class ResourceImageSerializer < ActiveModel::Serializer
  attributes :id, :caption, :photo_content_type, :photo_file_size, :photo_url, :photo_styles

  def photo_url
    object.photo.url
  end

  def photo_styles
    Hash[object.photo.styles.keys.map { |style| [style, object.photo(style)] }]
  end

  belongs_to :resource
end
