import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="timer"
export default class extends Controller {
  connect() {
    console.log("Connected to Timer JS")

    // const micToggle = document.querySelector("#mic-toggle");
    // console.log(micToggle)

    let time = document.getElementsByClassName("timer")
    console.log(time[0].innerHTML)
    console.log('aamir')

    let timings = 60;
    let i = 1;
    let s = 0;
    let m = 0;
    let myInterval;

    micToggle.addEventListener("click", () => {
      // console.log(time[0].innerHTML)
      console.log("im hereee!!!!")
      if (time[0].innerHTML) {
        console.log(time[0].innerHTML)
        clearInterval(myInterval)
      } else {
        myInterval = setInterval(Timeup, 10);
      }
    })

    function Timeup() {
      time[0].innerHTML = `${m}:${s}.${(timings*60+i)%100}`;
      i++;
      if (i > 99) {
        s++;
        i = 1;
      }
      if (s > 59) {
        s = 0
        m++;
        // i = 1;
      }
    }
  }
}
