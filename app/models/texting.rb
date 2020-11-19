class Texting < ApplicationRecord
  serialize :tags, Array
  serialize :resources, Array
end
