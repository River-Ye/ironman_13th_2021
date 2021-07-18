class Shop < ApplicationRecord
  strip_attributes
  acts_as_paranoid
  validates :name, uniqueness: true
end
