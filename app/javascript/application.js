// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import jquery from "jquery"
import "@nathanvda/cocoon"
// Esto hace que $ esté disponible en la consola y vistas
window.jQuery = jquery
window.$ = jquery