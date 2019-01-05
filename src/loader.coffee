headers = new Headers()
headers.append('Accept', 'text/html,application/xhtml+xml,application/xml')

loader_html = (url) ->
  new Promise (resolve, reject) =>
    window.fetch url,
      method: 'GET'
      mode: 'no-cors'
      cache: 'default'
      credentials: 'same-origin'
      headers: headers
    .then (res) -> resolve do res.text
    .catch (err) -> reject err


module.exports = loader_html
