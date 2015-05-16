# put animation code in here
# make things simple so this always loads
setTimeout (->
  # if nothing has loaded for 10s show the timeout block
  timeout = document.querySelector '#loading'
  return unless timeout?
  timeout.style.display = 'block'
), 10000