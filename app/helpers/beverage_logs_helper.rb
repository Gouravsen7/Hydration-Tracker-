module BeverageLogsHelper
  def estimate_calories(beverage_log)
    calories_per_unit = {
      "Black Coffee" => 2, "Espresso" => 1, "Americano" => 2,
      "Latte (Dairy-Based)" => 120, "Latte (Plant-Based)" => 80,
      "Green Tea" => 0, "Black Tea" => 2, "Herbal Tea" => 0,
      "Juice" => 50, "Smoothie" => 150,
      "Milk" => 100, "Oat Milk" => 90, "Soy Milk" => 80,
      "Soda" => 150, "Diet Soda" => 0,
      "Beer" => 200, "Wine" => 150
    }

    addition_calories = {
      "Sugar" => 20, "Milk" => 50, "Creamer" => 70,
      "Honey" => 30, "Protein Powder" => 80, "Electrolyte Powder" => 15
    }

    base_calories = calories_per_unit[beverage_log.category] || 0

    total_calories = base_calories * (beverage_log.quantity.to_f / 250)

    additions = beverage_log.additions.is_a?(Array) ? beverage_log.additions : beverage_log.additions.to_s.split(',')
    additions.each do |addition|
      total_calories += addition_calories[addition.strip] || 0
    end

    total_calories.round
  end

  def personalized_tips(beverage_log)
    tips = []

    if beverage_log.symptoms.include?("Acid Reflux / Heartburn") && beverage_log.temperature.to_i >= 50
      tips << "🔥 Hot drinks can trigger acid reflux; try drinking at a warm or room temperature instead."
    end

    if beverage_log.symptoms.include?("Bloating") && beverage_log.category == "Carbonated & Artificially Sweetened Drinks"
      tips << "🥤 Carbonated beverages may contribute to bloating; try limiting intake."
    end

    if beverage_log.symptoms.include?("Dry Mouth / Sticky Saliva") || beverage_log.symptoms.include?("Headache")
      if beverage_log.category == "Juice & Smoothies" || beverage_log.category == "Carbonated & Artificially Sweetened Drinks"
        tips << "🍭 High sugar intake can lead to dehydration; consider switching to water or herbal tea."
      end
    end

    tips.any? ? tips : ["✅ No specific recommendations based on your log."]
  end

  def gi_symptoms
    ["Bloating", "Discomfort", "Nausea", "Acid Reflux / Heartburn", "Burping / Excess Gas", "Diarrhea / Loose Stools", "Constipation", "Cramping / Abdominal Pain", "Urgency to Poop", "Mucus in Stool", "Fatty / Oily Stools (Steatorrhea)", "Undigested Food in Stool", "Feeling Full / Heavy Stomach", "Dizziness / Lightheadedness", "Headache", "Dry Mouth / Sticky Saliva"]
  end

  def beverage_additions
    ["Sugar", "Milk", "Creamer", "Lemon", "Lime", "Honey", "Artificial Sweeteners", "Protein Powder", "Electrolyte Powder"]
  end

  def quick_selection_buttons
    [
      { value: 250, unit: 'ml', label: '250 ml' },
      { value: 500, unit: 'ml', label: '500 ml' },
      { value: 8, unit: 'oz', label: '1 cup (8 oz)' },
      { value: 16, unit: 'oz', label: '2 cups (16 oz)' }
    ]
  end

  def symptom_severity_selections
    ["Mild", "Moderate", "Severe"]
  end

  def symptom_timing_selections
    ["Immediately", "Within 20–30 minutes", "2–5 hours", "5+ hours later"]
  end
end

