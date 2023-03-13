import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  connect() {
    console.log("Connected to Timer JS")

    const micToggle = document.querySelector("#mic-toggle");
    console.log(micToggle)

    let time = document.getElementsByClassName("timer")
    console.log(time[0].innerHTML)

    let timings = 60;
    let i = 1;
    let m = 0;
    let myInterval;

    micToggle.addEventListener("click", () => {
      console.log(time[0].innerHTML)

      if (time[0].innerHTML) {
        console.log(time[0].innerHTML)
        clearInterval(myInterval)
      } else {
        myInterval = setInterval(Timeup, 1000);
      }
    })

    function Timeup() {
      time[0].innerHTML = `${m} m :  ${(timings*60+i)%60} s`;
      i++;
      if (i > 59) {
        m++;
        i = 1;
      }
    }
  }
}
