#creating categories and sub-categories

categories_with_subcategories = {
  "Water-Based Beverages" => [
    "Plain Water", "Infused Water (Lemon, Cucumber, Mint, Ginger)",
    "Coconut Water", "Electrolyte-Infused Water", "Oral Rehydration Solutions"
  ],
  "Coffee-Based Beverages" => [
    "Black Coffee", "Espresso", "Americano", "Cold Brew",
    "Latte (Dairy-Based)", "Latte (Plant-Based)", "Cappuccino", "Mocha"
  ],
  "Tea-Based Beverages" => [
    "Green Tea", "Black Tea", "White Tea", "Oolong Tea",
    "Herbal Tea (Peppermint, Chamomile, Ginger, Fennel, Licorice Root)",
    "Matcha", "Yerba Mate"
  ],
  "Juice & Smoothies" => [
    "Fresh Fruit Juice (Apple, Orange, Pomegranate, etc.)",
    "Vegetable Juice (Carrot, Beet, Celery, etc.)",
    "Blended Smoothies (Fruit-Based)", "Blended Smoothies (Vegetable-Based)"
  ],
  "Dairy-Based Beverages" => [
    "Whole Milk", "Low-Fat Milk", "Skim Milk", "Lactose-Free Milk",
    "Kefir", "Buttermilk"
  ],
  "Plant-Based Milks" => [
    "Almond Milk (Unsweetened)", "Almond Milk (Sweetened)",
    "Oat Milk (Unsweetened)", "Oat Milk (Sweetened)",
    "Soy Milk", "Coconut Milk", "Rice Milk", "Hemp Milk"
  ],
  "Fermented & Probiotic Beverages" => [
    "Kombucha", "Lassi", "Yakult", "Kvass"
  ],
  "Carbonated & Artificially Sweetened Drinks" => [
    "Regular Soda", "Diet Soda", "Sparkling Water",
    "Energy Drinks", "Sports Drinks (Gatorade, Powerade)"
  ],
  "Alcoholic Beverages" => [
    "Beer", "Wine", "Cider", "Cocktails", "Liquor (Vodka, Whiskey, Gin, Tequila)"
  ],
  "Other" => ["Free-text input field for custom entry"]
}

categories_with_subcategories.each do |category_name, subcategories|
  category = Category.find_or_create_by(name: category_name)
  subcategories.each do |subcategory_name|
    Subcategory.find_or_create_by(name: subcategory_name, category: category)
  end
end

puts "Categories & Subcategories seeded successfully!"
