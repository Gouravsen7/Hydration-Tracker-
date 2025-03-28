class BeverageLog < ApplicationRecord
  has_one_attached :image

  belongs_to :category, optional: true
  belongs_to :subcategory, optional: true

  validates :date, :time, :quantity, :unit, presence: true
end
