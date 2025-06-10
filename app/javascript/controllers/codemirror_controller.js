import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="codemirror"
export default class extends Controller {
  connect() {
  import {basicSetup} from "codemirror"
  import {EditorView} from "@codemirror/view"

    const view = new EditorView({
      doc: "Start document",
      parent: this.element,
      extensions: [basicSetup]
  })
 }
}
