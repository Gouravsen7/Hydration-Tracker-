import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="update-symptoms-form"
export default class extends Controller {
  connect() {
    let symptomYes = document.querySelector("input[name='beverage_log[symptom_occurred]'][value='yes']");
    let symptomNo = document.querySelector("input[name='beverage_log[symptom_occurred]'][value='no']");
    let symptomDetails = document.getElementById("symptom_details");

    function toggleSymptomDetails() {
      symptomDetails.classList.toggle("hidden", !symptomYes.checked)
    }

    symptomYes.addEventListener("change", toggleSymptomDetails);
    symptomNo.addEventListener("change", toggleSymptomDetails);
  }
}
