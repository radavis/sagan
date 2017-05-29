$('form.delete-link').on('submit', (event) => {
  event.preventDefault()
  let method = event.target._method.value;
  let url = event.target.action;

  sweetAlert({
    title: "Are you sure?",
    type: "warning",
    showCancelButton: true,
    confirmButtonColor: '#DD6B55',
    confirmButtonText: 'Yes, delete it!'
  },
  () => {
    fetch(url, { method: 'DELETE' })
    .then((response) => {
      if (response.ok) {
        let id = url.split('/').pop()
        let element = document.getElementById(`links-${id}`)
        element.parentNode.removeChild(element);
      } else {
        console.log(response)
      }
    })
  })
})
