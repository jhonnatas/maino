# Pin npm packages by running ./bin/importmap

pin "application", preload: true
pin "@hotwired/turbo-rails", to: "turbo.min.js", preload: true
pin "@hotwired/stimulus", to: "stimulus.min.js", preload: true
pin "@hotwired/stimulus-loading", to: "stimulus-loading.js", preload: true
pin_all_from "app/javascript/controllers", under: "controllers"
pin "trix"
pin "@rails/actiontext", to: "actiontext.js"
#pin "sweetalert2", to: "https://ga.jspm.io/npm:sweetalert2@11.7.8/dist/sweetalert2.all.js"
pin_all_from "app/javascript/js", under: "js"
pin "sweetalert2", to: "https://ga.jspm.io/npm:sweetalert2@11.7.10/dist/sweetalert2.all.js"
