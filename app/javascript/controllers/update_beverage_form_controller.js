import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-beverage-form"
export default class extends Controller {
  connect() {
    // SubCategory update functionality

    const customSubcategoryInput = document.getElementById("custom-category");
    const categorySelect = document.getElementById("category-select");
    const customCategoryLableSelect = document.getElementById("custom-category-lable");
    const subcategorySelect = document.getElementById("subcategory-select");

    if (categorySelect && subcategorySelect) {
      categorySelect.addEventListener("change", function () {

        if (this.options[this.selectedIndex].text === "Other") {
          customSubcategoryInput.classList.remove("hidden"); // Show input field
          subcategorySelect.classList.add("hidden"); // Show input field
          customSubcategoryInput.required = true; // Make input required
          customCategoryLableSelect.innerHTML = 'Custom Category'
        } else {
          const categoryId = this.value;
          customCategoryLableSelect.innerHTML = 'Beverage SubCategory'
          subcategorySelect.classList.remove("hidden"); // Show input field
          customSubcategoryInput.classList.add("hidden"); // Hide input field
          customSubcategoryInput.required = false;

          fetch(`/categories/${categoryId}/subcategories`)
            .then(response => response.json())
            .then(data => {
              subcategorySelect.innerHTML = '<option value="">Select a subcategory</option>';
              data.forEach(subcategory => {
                const option = document.createElement("option");
                option.value = subcategory.id;
                option.textContent = subcategory.name;
                subcategorySelect.appendChild(option);
              });
            })
            .catch(error => console.error("Error fetching subcategories:", error));
        }

      });
    }

    // Quantity update functionality

    const unitSelect = document.getElementById("unit-select");
    const metricBtn = document.getElementById("metric-btn");
    const imperialBtn = document.getElementById("imperial-btn");
    const quantityInput = document.querySelector("[name='beverage_log[quantity]']");
    const presetButtons = document.querySelectorAll(".preset-btn");

    const metricUnits = ["ml", "L"];
    const imperialUnits = ["oz", "cups"];

    function updateUnits(units) {
      unitSelect.innerHTML = "";
      units.forEach(unit => {
        const option = document.createElement("option");
        option.value = unit;
        option.textContent = unit;
        unitSelect.appendChild(option);
      });
    }

    metricBtn.addEventListener("click", () => {
      updateUnits(metricUnits);
      metricBtn.classList.add("bg-[#ff5a5f]", "text-white");
      imperialBtn.classList.remove("bg-[#ff5a5f]", "text-white");
    });

    imperialBtn.addEventListener("click", () => {
      updateUnits(imperialUnits);
      imperialBtn.classList.add("bg-[#ff5a5f]", "text-white");
      metricBtn.classList.remove("bg-[#ff5a5f]", "text-white");
    });

    presetButtons.forEach(button => {
      button.addEventListener("click", function () {
        quantityInput.value = this.dataset.value;
        updateUnits([this.dataset.unit]);
      });
    });

    updateUnits(metricUnits);

    // Temperature slider functionality
    const tempSlider = document.getElementById("temperature-slider");
    const tempLabel = document.getElementById("temp-label");
    const tempEmoji = document.getElementById("temp-emoji");
    const toggleTempBtn = document.getElementById("toggle-temp");

    let isCelsius = true;

    const tempMappings = [
      { value: 0, emoji: "❄️", celsius: "Ice Cold (0°C)", fahrenheit: "Ice Cold (32°F)" },
      { value: 4, emoji: "🧊", celsius: "Chilled (4°C)", fahrenheit: "Chilled (40°F)" },
      { value: 10, emoji: "🥶", celsius: "Cool (10°C)", fahrenheit: "Cool (50°F)" },
      { value: 20, emoji: "🌡", celsius: "Room Temperature (20°C)", fahrenheit: "Room Temperature (68°F)" },
      { value: 50, emoji: "🔥", celsius: "Warm (50°C)", fahrenheit: "Warm (122°F)" },
      { value: 70, emoji: "☕", celsius: "Hot (70°C)", fahrenheit: "Hot (158°F)" },
      { value: 100, emoji: "♨️", celsius: "Boiling (100°C)", fahrenheit: "Boiling (212°F)" }
    ];

    function updateTemperatureDisplay(value) {
      const closestTemp = tempMappings.reduce((prev, curr) =>
        Math.abs(curr.value - value) < Math.abs(prev.value - value) ? curr : prev
      );

      tempEmoji.textContent = closestTemp.emoji;
      tempLabel.textContent = isCelsius ? closestTemp.celsius : closestTemp.fahrenheit;
    }

    tempSlider.addEventListener("input", function () {
      updateTemperatureDisplay(parseInt(tempSlider.value));
    });

    toggleTempBtn.addEventListener("click", function () {
      isCelsius = !isCelsius;
      toggleTempBtn.textContent = isCelsius ? "Switch to °F" : "Switch to °C";
      updateTemperatureDisplay(parseInt(tempSlider.value));
    });

    updateTemperatureDisplay(parseInt(tempSlider.value));
  }


  changeForm(event) {
    event.preventDefault();
    const currentStep = document.querySelector('#step_1');
    const requiredFields = currentStep.querySelectorAll("[required]");

    const isValid = Array.from(requiredFields).every((field) => field.reportValidity());

    if (!isValid) return;

    if (event.target.dataset.target === 'step_1') {
      document.getElementById("step_1").classList.add("hidden");
      document.getElementById("step_2").classList.remove("hidden");
    } else {
      document.getElementById("step_2").classList.add("hidden");
      document.getElementById("step_1").classList.remove("hidden");
    }
  }

  openConfirmationModal(event) {
    event.preventDefault(); // Prevent actual form submission

    // Dynamically find modal and summary content
    const modal = document.querySelector("#confirmation-modal");
    const summaryContent = document.querySelector("#summary-content");

    if (!modal || !summaryContent) {
      console.error("Modal or summary content not found!");
      return;
    }

    // Collect form values dynamically
    const categoryInput = document.querySelector("#category-select")
    const category = categoryInput.options[categoryInput.selectedIndex]?.text || "N/A";
    const subcategoryInput = document.querySelector("#subcategory-select")
    const subcategory = subcategoryInput.options[subcategoryInput.selectedIndex]?.text || "N/A";
    const temperature = document.querySelector("#temperature-slider")?.value || "N/A";

    const symptoms = Array.from(document.querySelectorAll('input[name="beverage_log[symptoms][]"]:checked'))
      .map((el) => el.value)
      .join(", ") || "None";

    const severity = document.querySelector("#symptom-severity")?.value || "N/A";
    const timing = document.querySelector("#symptom-timing")?.value || "N/A";
    const notes = document.querySelector("#beverage_log_notes")?.value || "None";

    // Populate summary content dynamically
    summaryContent.innerHTML = `
      <strong>Category:</strong> ${category} <br>
      <strong>Subcategory:</strong> ${subcategory} <br>
      <strong>Temperature:</strong> ${temperature}°C <br>
      <strong>Symptoms:</strong> ${symptoms} <br>
      <strong>Severity:</strong> ${severity} <br>
      <strong>Timing:</strong> ${timing} <br>
      <strong>Notes:</strong> ${notes}
    `;

    // Show the modal
    modal.classList.remove("hidden");
  }

  closeModal() {
    event.preventDefault(); // Prevent actual form submission
    const modal = document.querySelector("#confirmation-modal");
    if (modal) {
      modal.classList.add("hidden");
    }
  }

  submitForm() {
    const form = document.querySelector("form");
    if (form) {
      form.submit();
    }
  }
}
