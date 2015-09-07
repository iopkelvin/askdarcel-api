class PhoneNumber < ActiveRecord::Base
  default_scope ->{ order('id') }

  belongs_to :resource
end
