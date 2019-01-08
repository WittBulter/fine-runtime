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
  url = "#/#{label}"
  try
    lis = Array.from (fine_sides.getElementsByClassName('chapter') or [])
    link = lis.find (li) -> (li.getElementsByTagName('a')[0].getAttribute 'href') is url
    li.classList.remove 'active' for li in lis when li?
    link.classList.add 'active' if link
  catch err
    console.log err

find_label = (sides) ->
  path = decodeURI location.hash
  path = path.replace /^\#\//, ''
  has_side = sides.find (li) -> li.label is path

  has_catalog = /\//.test path
  if has_catalog
    [group, name] = path.split '/'
    side = sides.find (li) -> li.label is group
    has_side = (side.children.find (li) -> li.label is name) if side and side.children
    return "#{group}/#{has_side.label}" if has_side?
  return has_side.label if has_side?
  
  index = sides.find (li) -> Boolean li?.index
  return index.label if index?
  sides[0].label

listen = (settings) ->
  set_active find_label settings.sides
  window.addEventListener 'hashchange', () ->
    set_active find_label settings.sides

make_li = (side, parent_name) ->
  if side.children and Array.isArray side.children
    child_lis = make_li child, side.label for child in side.children
    return "<h2>#{side.label}</h2><ul>#{child_lis}</ul>"

  url = (parent_name and "#{parent_name}/#{side.label}") or side.label
  "<li>
    <p class=\"chapter link\">
      <a href=\"#/#{url}\">#{side.label}</a>
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
