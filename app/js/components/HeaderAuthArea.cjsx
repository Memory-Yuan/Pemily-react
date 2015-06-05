React = require 'react'
AuthAction = require '../actions/AuthAction'
AuthStore = require '../stores/AuthStore'
RB = require 'react-bootstrap'
{ Nav, NavItem, MenuItem, DropdownButton } = RB

getAllStoreData = ->
	isAuthenticated: AuthStore.isAuthenticated()

HeaderSignined = React.createClass
	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		AuthStore.addChangeListener(@_onChange)

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_onChange)

	handleSignout: ->
		AuthAction.signout()

	render: ->
		unless @state.isAuthenticated
			return (
				<Nav navbar right>
					<NavItem eventKey={1} href='#/signin'>Signin</NavItem>
				</Nav>
			)

		<Nav navbar right>
			<p className='navbar-text'>YES</p>
			<NavItem eventKey={1} href='#/pets'>My pets</NavItem>
			<DropdownButton eventKey={2} title={<i className='glyphicon glyphicon-cog'></i>}>
				<MenuItem eventKey='1'>Action</MenuItem>
				<MenuItem eventKey='2'>Another action</MenuItem>
				<MenuItem eventKey='3'>Something else here</MenuItem>
				<MenuItem divider />
				<MenuItem eventKey='4' onClick={ @handleSignout }>Signout</MenuItem>
			</DropdownButton>
		</Nav>

	_onChange: ->
		@setState getAllStoreData()

module.exports = HeaderSignined
