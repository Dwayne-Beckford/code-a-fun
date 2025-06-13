import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    this.modal = new window.bootstrap.Modal(this.element)

    // Only show if it hasn't already been shown (e.g., navigating back)
    if (!this.element.classList.contains("show")) {
      this.modal.show()
    }

    // this.onHidden = () => {


    //   this.modal.dispose()
    //   this.element.remove()
    // }

    this.element.addEventListener("hidden.bs.modal", this.onHidden)
  }

  disconnect() {
    if (this.modal) {
      this.modal.dispose()
    }
    this.element.removeEventListener("hidden.bs.modal", this.onHidden)
  }
}
