window.fine_content = {}

make_path = (sides) ->
  path = decodeURI location.hash
  path = path.replace /^\#\//, ''
  has_side = sides.find (li) -> li.label is path
  return has_side.url if has_side?
  
  index = sides.find (li) -> Boolean li?.index
  return index.url if index?
  sides[0].url

make_iframe = (path) ->
  url = "#{location.origin}/#{path}"
  "<div class=\"container-position\">
    <div class=\"container\">
      <iframe src=\"#{url}\" frameborder=\"0\"></iframe>
    </div>
  </div>"

listen = (settings) ->
  return if window.fine_listen_hash?
  window.fine_listen_hash = true
  window.onhashchange = () ->
    iframe = make_iframe (make_path settings.sides)
    window.fine_content.innerHTML = ''
    window.fine_content.innerHTML = iframe

content = (settings) ->
  listen settings
  path = make_path settings.sides
  
  iframe = make_iframe path
  el = document.createElement 'div'
  window.fine_content = el
  el.innerHTML = iframe
  el

module.exports =
  run: content

