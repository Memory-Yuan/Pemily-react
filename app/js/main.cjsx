require 'bootstrap-css'
require 'bootstrap-js'
require '../css/main.scss'
React = require 'react'
Router = require 'react-router'
{ Route, DefaultRoute, RouteHandler, NotFoundRoute } = Router
DocumentTitle = require 'react-document-title'

GlobalContainer = require './containers/GlobalContainer'
Header = require './components/Header'
Signin = require './components/Signin'
Register = require './components/Register'
Index = require './components/Index'
MyPets = require './components/MyPets'
NotFound = require './components/NotFound'
PostRiver = require './components/PostRiver'
PetProfile = require './components/PetProfile'
PetsAll = require './components/PetsAll'
PetIndex = require './components/PetIndex'
MyFollow = require './components/MyFollow'

App = React.createClass
	render: ->
		<DocumentTitle title='Pemily'>
			<GlobalContainer>
				<Header/>
				<RouteHandler/>
			</GlobalContainer>
		</DocumentTitle>

routes = (
	<Route name='app' path='/' handler={App}>
		<Route name='signin' handler={Signin}/>
		<Route name='register' handler={Register}/>
		<Route name='mypets' handler={MyPets}/>
		<Route path='mypets/:id' handler={PetProfile}>
			<DefaultRoute handler={PetIndex}/>
		</Route>
		<Route name='pets' handler={PetsAll}/>
		<Route path='pets/:id' handler={PetProfile}>
			<DefaultRoute handler={PetIndex}/>
		</Route>
		<Route name='pets/:id/test/:t_id' handler={PetsAll}/>
		<Route name='channel' handler={PostRiver}/>
		<Route name='myfollow' handler={MyFollow}/>
		<DefaultRoute handler={Index}/>
		<NotFoundRoute handler={NotFound} />
	</Route>
)

Router.run(routes, (Handler) ->
	React.render(<Handler/>, $('#app')[0])
)