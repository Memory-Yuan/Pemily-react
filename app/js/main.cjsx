require 'bootstrap-css'
require 'bootstrap-js'
require '../css/main.scss'
React = require 'react'
Router = require 'react-router'
Route = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler
# NotFoundRoute = Router.NotFoundRoute
# Redirect = Router.Redirect
# Link = Router.Link

PetBox = require './components/PetBox'

About = React.createClass
	render: ->
		<h2>About</h2>

Inbox = React.createClass
	render: ->
		<div>
			<h2>Inbox</h2>
			<RouteHandler/>
		</div>

Message = React.createClass
	render: ->
		<div>
			<h3>Message</h3>
			<RouteHandler/>
		</div>

MessageDetail = React.createClass
	render: ->
		<h4>Detail</h4>

App = React.createClass
	render: ->
		<div>
			<h1>App</h1>
			<RouteHandler/>
		</div>

routes = (
	<Route handler={App}>
		<Route name='pets' handler={PetBox}/>
		<Route name='about' handler={About}/>
		<Route name='inbox' handler={Inbox}>
			<Route name='messages' handler={Message}>
				<Route path=':id' handler={MessageDetail}/>
			</Route>
		</Route>
	</Route>
)

Router.run(routes, (Handler) ->
	React.render(<Handler/>, document.getElementById('content'))
)