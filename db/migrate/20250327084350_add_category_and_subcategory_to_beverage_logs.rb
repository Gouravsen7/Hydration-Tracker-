class AddCategoryAndSubcategoryToBeverageLogs < ActiveRecord::Migration[7.2]
  def change
    add_reference :beverage_logs, :category, null: false, foreign_key: true
    add_reference :beverage_logs, :subcategory, foreign_key: true
  end
end
