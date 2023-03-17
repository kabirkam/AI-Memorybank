import { Controller } from "@hotwired/stimulus"
import flatpickr from 'flatpickr'

// Connects to data-controller="reminders2"
export default class extends Controller {
  connect() {
    console.log('in the reminders2 controller');
    const myDate = document.getElementById("reminder2_date_time");

    flatpickr(myDate, {
      minDate: 'today',
      enableTime: true
    })
  }
}
