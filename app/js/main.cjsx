require 'bootstrap-css'
require 'bootstrap-js'
require '../css/main.scss'
React = require 'react'
Router = require 'react-router'
{ Route, DefaultRoute, RouteHandler, NotFoundRoute } = Router
# Redirect = Router.Redirect
# Link = Router.Link
DocumentTitle = require 'react-document-title'
Mixins = require './mixins/Mixins'

Header = require './components/Header'
Signin = require './components/Signin'
Register = require './components/Register'
MyPets = require './components/MyPets'
NotFound = require './components/NotFound'
PostRiver = require './components/PostRiver'

###
ValidationMixin
previous process
###

RB = require 'react-bootstrap'
Button = RB.Button
# tmp page start ----------------------

Inbox = React.createClass
	mixins: [Mixins.Authenticated]
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
	<Route name='app' path='/' handler={App}>
		<Route name='signin' handler={Signin}/>
		<Route name='register' handler={Register}/>
		<Route name='mypets' handler={MyPets}/>
		<Route name='inbox' handler={Inbox}>
			<Route name='messages' handler={Message}>
				<Route path=':id' handler={MessageDetail}/>
			</Route>
		</Route>
		<DefaultRoute handler={PostRiver}/>
		<NotFoundRoute handler={NotFound} />
	</Route>
)

Router.run(routes, (Handler) ->
	React.render(<Handler/>, $('#app')[0])
)