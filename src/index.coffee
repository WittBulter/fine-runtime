sides = require './sides'
links = require './links'
content = require './content'

app = document.getElementById 'app'

settings = window.fine_settings

side_element = sides.run settings

conent_element = content.run settings

link_element = links.run settings


app.appendChild side_element
app.appendChild conent_element
app.appendChild link_element
