// app/javascript/controllers/hint_controller.js
import { Controller } from "@hotwired/stimulus"
// import openai from "openai"; // You need to import this to use Openai
// Connects to data-controller="hint"
export default class extends Controller {
  static targets = ["formInput", "formOutput"]
  connect() {
    console.log(this.formOutputTarget)
  }
  csrfToken() {
    return document.querySelector("meta[name='csrf-token']").content
  }
  sendFeedback(e) {
    e.preventDefault()
    fetch(`${window.location.href}/feedbacks`, {
      method: "POST",
      headers: {"Accept": "application/json", 'X-CSRF-Token': this.csrfToken()},
      body: {"user_answer": `${this.formInputTarget.value}`}
    } ).then(response => {
      console.log(response)
      return response.json()
    }).then(data => {
      console.log(data)
      this.formOutputTarget.innerHTML = data
    })

    this.formOutputTarget.innerHTML = `<div>
      <div class="spinner-border" role="status">
        <span class="visually-hidden">Loading...</span>
      </div>
      <p>We are crunching the numbers</p>
    </div>`


  }
}
