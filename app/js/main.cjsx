require 'bootstrap-css'
require 'bootstrap-js'
require '../css/main.scss'
React = require 'react'
Router = require 'react-router'
Route = Router.Route
DefaultRoute = Router.DefaultRoute
RouteHandler = Router.RouteHandler
NotFoundRoute = Router.NotFoundRoute
# Redirect = Router.Redirect
# Link = Router.Link
DocumentTitle = require 'react-document-title'

Header = require './components/Header'
Signin = require './components/Signin'
PetBox = require './components/PetBox'
NotFound = require './components/NotFound'

# tmp page start ----------------------
Index = React.createClass
	render: ->
		<div>
			<h1>Pemily</h1>
		</div>

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

# tmp page end ------------------------

App = React.createClass
	render: ->
		<DocumentTitle title='Pemily'>
			<div>
				<Header/>
				<div className='container-fluid'>
					<RouteHandler/>
				</div>
				
			</div>
		</DocumentTitle>

routes = (
	<Route handler={App}>
		<Route name='signin' handler={Signin}/>
		<Route name='pets' handler={PetBox}/>
		<Route name='about' handler={About}/>
		<Route name='inbox' handler={Inbox}>
			<Route name='messages' handler={Message}>
				<Route path=':id' handler={MessageDetail}/>
			</Route>
		</Route>
		<DefaultRoute handler={Index}/>
		<NotFoundRoute handler={NotFound} />
	</Route>
)

Router.run(routes, (Handler) ->
	React.render(<Handler/>, $('#app')[0])
)