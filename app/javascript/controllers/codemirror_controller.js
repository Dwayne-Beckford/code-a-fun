import { Controller } from "@hotwired/stimulus"
import { basicSetup } from "codemirror"
import { EditorView, keymap} from "@codemirror/view"
// import {Extension, EditorState} from "@codemirror/state"
import {indentWithTab} from "@codemirror/commands"
// import {javascript} from "@codemirror/lang-javascript"

// Connects to data-controller="codemirror"
export default class extends Controller {
  connect() {
    const myTheme = EditorView.theme(
      {
        "&": {
          color: "white",
          backgroundColor: "#034",
        },
        ".cm-content": {
          caretColor: "#0e9",
        },
        "&.cm-focused .cm-cursor": {
          borderLeftColor: "#0e9",
        },
        "&.cm-focused .cm-selectionBackground, ::selection": {
          backgroundColor: "#074",
        },
        ".cm-gutters": {
          backgroundColor: "#045",
          color: "#ddd",
          border: "none",
        },
      },
      { dark: true }
    )

    const view = new EditorView({
      doc: "Start document",
      parent: this.element,
      extensions: [
        basicSetup,
        myTheme,
        // keymap.of[indentWithTab]
      ],
    })
  }


}
