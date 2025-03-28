class AddSymptomsToBeverageLogs < ActiveRecord::Migration[7.0]
  def change
    add_column :beverage_logs, :symptom_occurred, :boolean, default: false
    add_column :beverage_logs, :symptoms, :text, array: true, default: []
    add_column :beverage_logs, :other_symptom, :string
    add_column :beverage_logs, :symptom_severity, :string
    add_column :beverage_logs, :symptom_timing, :string
  end
end
