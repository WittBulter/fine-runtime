sides = require './sides'
content = require './content'

app = document.getElementById 'app'

settings = window.fine_settings

side_element = sides.run settings.sides

conent_element = content.run settings.sides


app.appendChild side_element
app.appendChild conent_element
