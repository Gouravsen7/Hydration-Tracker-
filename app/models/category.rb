class Category < ApplicationRecord
  has_many :subcategories, dependent: :destroy
  has_many :beverage_logs

  validates :name, presence: true, uniqueness: true
end
