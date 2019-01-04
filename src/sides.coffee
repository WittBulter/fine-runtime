###
  generate the elements of the page sidebar.
  
  side data provided by @fine/cli:
  type side = {
    label: string
    url: string
  }
###
make_li = (side) ->
  "<li>
    <a href=\"#/#{side.label}\">#{side.label}</a>
  </li>"

make_ul = (list) ->
  "<div>
    <ul>#{list}</ul>
  </div>"

make_sides = (side_list) ->
  list = ''
  list += make_li item for item in side_list
  html = make_ul list
  el = document.createElement 'div'
  el.innerHTML = html
  el

module.exports =
  run: make_sides
