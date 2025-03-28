class AddMoreColumnsInBeverageLogs < ActiveRecord::Migration[7.2]
  def change
    remove_column :beverage_logs, :category
    remove_column :beverage_logs, :subcategory
    change_column :beverage_logs, :additions, :text, array: true, default: []
    add_column :beverage_logs, :other_addition, :string
    add_column :beverage_logs, :other_category, :string
  end
end
