import { Controller } from "stimulus";

export default class extends Controller {
  static targets = ["shortenedUrl"];

  onSuccess(event) {
    let [data, status, xhr] = event.detail;
    this.shortenedUrlTarget.innerHTML = xhr.response;
  }
}
