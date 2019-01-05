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
  el

module.exports =
  run: make_sides
