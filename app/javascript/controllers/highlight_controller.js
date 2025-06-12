import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = ["editor", "highlight"]

  connect() {
    this.updateHighlight()
  }

  updateHighlight() {
    const textarea = this.editorTarget
    const highlight = this.highlightTarget

    const code = textarea.value
      .replace(/&/g, "&amp;")
      .replace(/</g, "&lt;")
      .replace(/>/g, "&gt;")

    highlight.innerHTML = window.Prism.highlight(
      code,
      window.Prism.languages.ruby,
      "ruby"
    )
  }

  handleTab(event) {
    if (event.key === "Tab") {
      event.preventDefault()

      const textarea = this.editorTarget
      const start = textarea.selectionStart
      const end = textarea.selectionEnd
      const indent = "  "

      textarea.value =
        textarea.value.substring(0, start) +
        indent +
        textarea.value.substring(end)

      textarea.selectionStart = textarea.selectionEnd = start + indent.length

      this.updateHighlight()
    }
  }
}
