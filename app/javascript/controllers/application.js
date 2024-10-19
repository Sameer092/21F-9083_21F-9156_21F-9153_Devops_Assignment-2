import { Application } from "@hotwired/stimulus"

const application = Application.start()
// app/javascript/packs/application.js
require("controllers/friends_search");

// Configure Stimulus development experience
application.debug = false
window.Stimulus   = application

export { application }
