// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"

import "jquery"
// Esto hace que $ esté disponible en la consola y vistas (un hack necesario para cursos viejos)
window.jQuery = jquery
window.$ = jquery