###
  generate the elements of the page sidebar.
  
  side data provided by @fine/cli:
  type side = {
    label: string
    url: string
  }
###
window.fine_sides = null

set_active = (label) ->
  return if not window.fine_sides
  try
    lis = Array.from (fine_sides.getElementsByClassName('chapter') or [])
    link = lis.find (li) -> li.getElementsByTagName('a')[0].innerText is label
    li.classList.remove 'active' for li in lis when li?
    link.classList.add 'active' if link
  catch err
    console.log err

find_label = (sides) ->
  path = decodeURI location.hash
  path = path.replace /^\#\//, ''
  has_side = sides.find (li) -> li.label is path
  return has_side.label if has_side?
  
  index = sides.find (li) -> Boolean li?.index
  return index.label if index?
  sides[0].label

listen = (settings) ->
  set_active find_label settings.sides
  window.addEventListener 'hashchange', () ->
    set_active find_label settings.sides

make_li = (side) ->
  "<li>
    <p class=\"chapter link\">
      <a href=\"#/#{side.label}\">#{side.label}</a>
    </p>
  </li>"

make_ul = (list, settings) ->
  "<div class=\"side-title\"><h2>#{settings.project_name or 'preview'}</h2></div>
  <ul class=\"side-list\">#{list}</ul>"

make_sides = (settings) ->
  list = ''
  list += make_li item for item in settings.sides
  html = make_ul list, settings
  el = document.createElement 'div'
  el.setAttribute 'class', 'side-position'
  el.innerHTML = html
  window.fine_sides = el
  listen(settings)
  el

module.exports =
  run: make_sides
