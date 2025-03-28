class Subcategory < ApplicationRecord
  belongs_to :category
  has_many :beverage_logs

  validates :name, presence: true, uniqueness: { scope: :category_id }
end
