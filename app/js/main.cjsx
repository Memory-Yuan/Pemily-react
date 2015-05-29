require 'bootstrap-css'
require 'bootstrap-js'
require '../css/main.scss'
React = require 'react'
PetBox = require './components/PetBox'
# DemoApp = require './components/DemoApp'

# React.render(<PetBox url='http://pemily-api.dev/api/v1/pets'/>, document.getElementById('content'))
React.render(<PetBox/>, document.getElementById('content'))
# React.render(<DemoApp/>, document.getElementById('content'))