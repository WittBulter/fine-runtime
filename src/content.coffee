window.fine_content = {}

make_path = (sides) ->
  console.log 111
  path = decodeURI location.hash
  path = path.replace /^\#\//, ''
  has_side = sides.find (li) -> li.label is path
  return has_side.url if has_side?
  
  index = sides.find (li) -> Boolean li?.index
  return index.url if index?
  sides[0].url

make_iframe = (path) ->
  url = "#{location.origin}/#{path}"
  "<iframe src=\"#{url}\" frameborder=\"0\">
  </iframe>"

listen = (sides) ->
  return if window.fine_listen_hash?
  window.fine_listen_hash = true
  window.onhashchange = () ->
    iframe = make_iframe make_path sides
    window.fine_content.innerHTML = ''
    window.fine_content.innerHTML = iframe

content = (sides) ->
  listen sides
  path = make_path sides
  
  iframe = make_iframe path
  el = document.createElement 'div'
  window.fine_content = el
  el.innerHTML = iframe
  el

module.exports =
  run: content

