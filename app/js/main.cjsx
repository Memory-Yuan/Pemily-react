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
PetBox = require './components/PetBox'
NotFound = require './components/NotFound'

###
ValidationMixin

###


RB = require 'react-bootstrap'
Button = RB.Button
# tmp page start ----------------------
Index = React.createClass
	getInitialState: ->
		test: true


	render: ->
		
		return <div>test</div> if @state.test
		<div>
			<h1>Pemily</h1>
		</div>

About = React.createClass
	# mixins: [Router.State, Router.Navigation]
	# getInitialState: ->
	# 	nextPath: @getQuery().nextPath

	testTrans: ->
		# console.log @state.nextPath if @state.nextPath?
		# @replaceWith(@state.nextPath) if @state.nextPath?
		# @replaceWith('/')

	render: ->
		<div>
			<h2>About</h2>
			<Button className='btn btn-default' onClick={@testTrans}>trans</Button>
		</div>
		

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