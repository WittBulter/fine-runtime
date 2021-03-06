loader_html = require './loader'
window.fine_content = {}


make_path = (sides) ->
  path = decodeURI location.hash
  path = path.replace /^\#\//, ''
  has_side = sides.find (li) -> li.label is path

  has_catalog = /\//.test path
  if has_catalog
    [group, name] = path.split '/'
    side = sides.find (li) -> li.label is group
    has_side = (side.children.find (li) -> li.label is name) if side and side.children

  return has_side.url if has_side?
  
  index = sides.find (li) -> Boolean li?.index
  return index.url if index?
  sides[0].url

listen = (settings) ->
  return if window.fine_listen_hash?
  window.fine_listen_hash = true
  window.addEventListener 'hashchange', () ->
    update_content make_path settings.sides

update_content = (path) ->
  url = "#{location.origin}/#{path}"
  insert = (text) ->
    _div = document.createElement 'div'
    _div.setAttribute 'class', 'container-inner'
    _div.innerHTML = text
    window.fine_content.innerHTML = ''
    window.fine_content.appendChild _div
  loader_html url
    .then insert
    .catch (err) -> console.log err
    
content = (settings) ->
  listen settings
  box = document.createElement 'div'
  box.setAttribute 'class', 'container-position'
  container = document.createElement 'div'
  container.setAttribute 'class', 'container'
  window.fine_content = container
  box.appendChild container
  
  update_content make_path settings.sides
  box
  

module.exports =
  run: content
