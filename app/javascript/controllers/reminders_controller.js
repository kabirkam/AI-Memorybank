import { Controller } from "@hotwired/stimulus"
import flatpickr from 'flatpickr'
// import "flatpickr/dist/themes/dark.css"
// require('flatpickr/dist/flatpickr.css')

// Connects to data-controller="reminders"
export default class extends Controller {
  connect() {
    console.log('in the reminders controller');
    const myDate = document.getElementById("reminder_date_time");

    flatpickr(myDate, {
      minDate: 'today',
      enableTime: true,
    })
  }
}
