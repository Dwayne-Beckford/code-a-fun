// app/javascript/controllers/hint_controller.js
import { Controller } from "@hotwired/stimulus"
// import openai from "openai"; // You need to import this to use Openai
// Connects to data-controller="hint"
export default class extends Controller {
  static targets = ["formInput"]
  csrfToken() {
    return document.querySelector("meta[name='csrf-token']").content
  }
  sendFeedback() {
    fetch(`${window.location.href}/feedbacks`, {
      method: "POST",
      headers: {"Accept": "application/json", 'X-CSRF-Token': this.csrfToken()},
      body: {"user_answer": `${this.formInputTarget.value}`}
    } )
  }
}
