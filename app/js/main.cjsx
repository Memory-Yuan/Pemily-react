require 'materialize-css/bin/materialize.css'
require 'materialize-css/bin/materialize.js'
require '../css/main.scss'

Router = require 'react-router'
{ Route, DefaultRoute, RouteHandler, NotFoundRoute } = Router

DocumentTitle = require 'react-document-title'
GlobalContainer = require './containers/GlobalContainer'
Header = require './components/Header'
Index = require './components/Index'
NotFound = require './components/NotFound'
Signin = require './components/Signin'
Register = require './components/Register'
MyPets = require './components/MyPets'
MyFollow = require './components/MyFollow'
PetProfile = require './components/PetProfile'
PetsAll = require './components/PetsAll'
PetProfileIndex = require './components/PetProfileIndex'
PostRiver = require './components/PostRiver'

###
create & update時預先顯示結果的處理
loading
###

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
		<Route name='myfollow' handler={MyFollow}/>
		<Route name='channel' handler={PostRiver}/>
		<Route name='pets' handler={PetsAll}/>
		<Route path='pets/:id' handler={PetProfile}>
			<DefaultRoute handler={PetProfileIndex}/>
		</Route>
		<DefaultRoute handler={Index}/>
		<NotFoundRoute handler={NotFound} />
	</Route>
)

Router.run(routes, (Handler) ->
	React.render(<Handler/>, $('#app')[0])
)