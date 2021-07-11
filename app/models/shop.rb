class Shop < ApplicationRecord
  strip_attributes
  validates :name, uniqueness: true
end
