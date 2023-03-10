import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="pop-up-msg"
export default class extends Controller {
  connect() {
    console.log("Connected to Pop Up Msg JS")
  }

  showMsg() {
    console.log("Message Clicked!")

    const msgBox = document.querySelector(".pop-up-msg-box-container")
    msgBox.classList.add("active")

    const showPage = document.querySelector(".note-body")
    showPage.classList.add("")


  }

  closeMsg() {
    console.log("Close Btn Clicked!")

    const msgBox = document.querySelector(".pop-up-msg-box-container")
    msgBox.classList.remove("active")

    const msgBox = document.querySelector(".pop-up-msg-box-container")

  }
}
