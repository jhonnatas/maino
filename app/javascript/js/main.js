// This folder was created to put the custom code.
import Swal from "sweetalert2"
import * as sweetalert2 from "sweetalert2"

// the necessary JavaScript code to present a sweet alert box when users click this button
window.addEventListener(('turbo:load'), () => {
  document.addEventListener('submit', (event) => {
    if (event.target && event.target.className === 'delete-post') {
      event.preventDefault()
      Swal.fire({
        title: "Are you sure?",
        showCancelButton: true
      })
        .then((result) => {
          if (result.isConfirmed) {
            document.querySelector('.delete-post').submit()
          }
        })
        .catch(event.preventDefault())
    }
  })
})