import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static values = { confirmMessage: String };

  confirm(event) {
    if (!(window.confirm(this.confirmMessageValue))) {
      event.preventDefault();
      event.stopImmediatePropagation();
    };
  };
}

document.addEventListener("turbo:load", function () {
  document.querySelectorAll("[data-confirm]").forEach(function (element) {
    element.addEventListener("click", function (event) {
      if (!confirm(this.getAttribute("data-confirm"))) {
        event.preventDefault();
      }
    });
  });
});
