webpack = require 'webpack'
path = require 'path'

config = {
  entry: [
    'webpack-dev-server/client?http://localhost:8080',
    'webpack/hot/dev-server',
    path.resolve(__dirname, 'app/js/main.cjsx')
  ]

  output:
    path: path.resolve(__dirname, 'build')
    filename: 'bundle.js'

  devServer:
    devtool: "eval"
    debug: true
    contentBase: path.resolve(__dirname, 'build')
    info: true
    hot: true
    # inline: true
    colors: true

  module:
    noParse: [],
    loaders: [
      { test: /\.cjsx$/, loaders: ['react-hot', 'coffee', 'cjsx'], include: path.join(__dirname, 'app') },
      { test: /\.coffee$/, loader: 'coffee' },
      { test: /\.css$/, loader: "style!css" }
      { test: /\.scss$/, loader: "style!css!sass" },
      { test: /\.less$/, loader: "style!css!less" },
      { test: /\.(png|jpg|jpeg|gif|svg)$/, loader: 'url?limit=10000' },
      { test: /\.(woff|woff2)$/, loader: 'url?limit=100000' },
      { test: /\.(ttf|eot)$/, loader: "file" }
    ]

  resolve:
    alias:
      'bootstrap-js': 'bootstrap/dist/js/bootstrap.min.js'
      'bootstrap-css': 'bootstrap/dist/css/bootstrap.min.css'
    extensions: ['', '.js', '.cjsx', '.coffee', '.css', '.scss', '.less'] 

  plugins: [
    new webpack.HotModuleReplacementPlugin(),
    new webpack.NoErrorsPlugin(), #更改完的程式碼有語法錯誤時不要重新整理。
    new webpack.IgnorePlugin(/vertx/) # https://github.com/webpack/webpack/issues/353
    new webpack.ProvidePlugin({
      $: 'jquery'
      jQuery: "jquery",
      "window.jQuery": "jquery",
      "root.jQuery": "jquery"
    })
  ]

  node:
    net: 'empty'
    tls: 'empty'
    dns: 'empty'
}

module.exports = config
