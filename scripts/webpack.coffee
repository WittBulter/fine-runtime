fs = require 'fs'
path = require 'path'
webpack = require 'webpack'
Html_plugin = require 'html-webpack-plugin'
Copy_plugin = require 'copy-webpack-plugin'

mock_file = null
find_mock = () ->
  fs.readFileSync (path.join __dirname, '../mocks/mock.json'), 'utf-8'
insert_mock = (env) ->
  return if not env.development
  mock_file = do find_mock if not mock_file
  "<script>window.fine_settings=#{mock_file}</script>"

copy = new Copy_plugin [{
  from: path.resolve __dirname, '../mocks/'
  to: path.resolve __dirname, '../dist'
  ignore: ['.*']
}]

make_plugins = (env) ->
  plugins = [
    new Html_plugin
      inject: false
      filename: path.join __dirname, '../dist/index.html'
      template: require 'html-webpack-template'
      title: 'run-time demo'
      headHtmlSnippet: insert_mock env
      bodyHtmlSnippet: '<div id="app"></div>'
      minify:
        removeComments: true
        collapseWhitespace: true
        minifyCSS: true
        minifyJS: true
        collapseBooleanAttributes: true
  ]
  return plugins if not env.development
  [plugins..., copy]

module.exports = (env = {}) ->
  entry:
    run_time: path.join __dirname, '../src/index.coffee'

  output:
    path: path.resolve __dirname, '../dist'
    filename: '[name].js'

  resolve:
    extensions: ['.coffee', '.js']

  devtool: 'source-map'

  devServer:
    historyApiFallback: true

  module:
    rules: [
      test: /\.coffee$/
      exclude: /node_modules/
      use: [{
        loader: 'coffee-loader'
        options:
          sourceMap: true
      }]
    ]

  plugins: make_plugins env
