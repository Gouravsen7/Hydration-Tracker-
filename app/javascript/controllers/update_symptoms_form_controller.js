import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-symptoms-form"
export default class extends Controller {
  connect() {
    let symptomYes = document.querySelector("input[name='beverage_log[symptom_occurred]'][value=true]");
    let symptomNo = document.querySelector("input[name='beverage_log[symptom_occurred]'][value=false]");
    let symptomDetails = document.getElementById("symptom_details");

    function toggleSymptomDetails() {
      symptomDetails.classList.toggle("hidden", !symptomYes.checked)
    }

    symptomYes.addEventListener("change", toggleSymptomDetails);
    symptomNo.addEventListener("change", toggleSymptomDetails);
  }
}
