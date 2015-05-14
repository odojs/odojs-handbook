cycle = (cb) ->
  prev = null
  handle = null
  step = (t) ->
    if prev is null
      prev = t
      return handle = window.requestAnimationFrame step
    dt = t - prev
    prev = t
    cb dt
    handle = window.requestAnimationFrame step
  handle = window.requestAnimationFrame step
  fin: ->
    window.cancelAnimationFrame handle
    window.__loadinghandle = null
    document
      .querySelector '.loading'
      .remove()

path = document.querySelector '.loading path'
state = 0
window.__loadinghandle = cycle (dt) ->
  state += dt / 500

setTimeout (->
  return if !window.__loadinghandle?
  timeout = document.querySelector '.loading .timeout'
  timeout.style.display = 'block'
), 10000