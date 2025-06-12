import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  connect() {
    if (!this.modal) {
      this.modal = new window.bootstrap.Modal(this.element)

      if (!this.element.classList.contains("show")) {
        this.modal.show()
      }

      this.onHidden = () => {
        this.modal.dispose()
        this.modal = null
        this.element.remove()
      }

      this.element.addEventListener("hidden.bs.modal", this.onHidden)
    }
  }

  disconnect() {
    if (this.modal) {
      try {
        this.modal.hide()
        this.modal.dispose()
      } catch (e) {
        console.warn("Modal already cleaned up or gone", e)
      }

      this.modal = null
    }

    if (this.onHidden) {
      this.element.removeEventListener("hidden.bs.modal", this.onHidden)
    }
  }
}
