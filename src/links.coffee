

# link { name: string, url: string }
make_a = (link) ->
  return '' if not link or not link.name
  "<a href=\"#{link.url}\" target='_blank'>#{link.name}</a>"

make_links = (settings) ->
  if not settings.links or settings.links.length is 0
    return document.createElement 'div'

  el = document.createElement 'div'
  el.setAttribute 'class', 'chains'
  links = settings.links
    .map (link) -> make_a link
    .filter (r) -> r and r isnt ''
    .reduce (html, next) -> "#{html}#{next}"
  el.innerHTML = links
  el

module.exports =
  run: make_links

