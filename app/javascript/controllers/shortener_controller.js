import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["formInput", "successMsg"];

  connect() {
    this.formInputTarget.select();
    if (this.hasSuccessMsgTarget) {
      this.formInputTarget.disabled = true;
      document.execCommand("copy");
    }
  }

  typing(event) {
    // TODO: on-the-fly hints for URL verification
  }
}
