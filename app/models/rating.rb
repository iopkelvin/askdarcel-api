class Rating < ActiveRecord::Base
  belongs_to :resource
  belongs_to :rating_option

  accepts_nested_attributes_for :rating_option

  validates :device_id, presence: true
  validates_presence_of :rating_option
  validates :resource_id,
            uniqueness: {
              scope: :device_id,
              message: 'has already been rated by this device id',
            }

  validate :valid_option

  protected

  def valid_option
    errors.add(:rating_option, "does not exist") unless RatingOption.find_by(name: self.rating_option.name)
  end

  def autosave_associated_records_for_rating_option
    self.rating_option = RatingOption.find_by(name: self.rating_option.name)
  end
end
