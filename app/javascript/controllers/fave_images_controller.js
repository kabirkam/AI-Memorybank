import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="fave-images"
export default class extends Controller {
  connect() {
    console.log("Connected to Fave Images JS")
  }

  showCarousel() {
    console.log("Images Clicked")

    const imagesCarousel = document.querySelector(".carousel-container")
    imagesCarousel.classList.add("carousel-show")

    // const showPage = document.querySelector(".note-body")
    // showPage.classList.add("")
  }

  closeCarousel() {
    console.log("Close Btn Clicked!")

    const imagesCarousel = document.querySelector(".carousel-container")
    imagesCarousel.classList.remove("carousel-show")

    // const showPage = document.querySelector(".note-body")
  }
}



