class CreateBeverageLogs < ActiveRecord::Migration[7.2]
  def change
    create_table :beverage_logs do |t|
      t.date :date
      t.time :time
      t.string :category
      t.string :subcategory
      t.float :quantity
      t.string :unit
      t.integer :temperature
      t.text :additions, array: true, default: []
      t.text :notes

      t.timestamps
    end
  end
end
