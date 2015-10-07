class Rating < ActiveRecord::Base
  belongs_to :resource
  belongs_to :rating_option

  scope :created_by, ->(device_id) { where(device_id: device_id) }

  accepts_nested_attributes_for :rating_option

  validates :device_id, presence: true
  validates_presence_of :resource
  validates_presence_of :rating_option
  validates :resource_id,
            uniqueness: {
              scope: :device_id,
              message: 'has already been rated by this device id'
            }

  validate :valid_option

  protected

  def valid_option
    errors.add(:rating_option_name, 'is not valid') unless RatingOption.find_by(name: rating_option.name)
  end

  def autosave_associated_records_for_rating_option
    self.rating_option = RatingOption.find_by(name: rating_option.name)
  end
end
