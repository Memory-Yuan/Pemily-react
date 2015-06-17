React = require 'react'
AuthAction = require '../actions/AuthAction'
AuthStore = require '../stores/AuthStore'
PetAction = require '../actions/PetAction'
PetStore = require '../stores/PetStore'
RB = require 'react-bootstrap'
{ Nav, NavItem, MenuItem, DropdownButton } = RB

getAllStoreData = ->
	isAuthenticated: AuthStore.isAuthenticated()
	userData: AuthStore.getUserData()
	thisPetId: PetStore.getThisPetId()
	thisPetData: PetStore.getThisPetData()

HeaderSignined = React.createClass
	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		AuthStore.addChangeListener(@_onChange)
		PetStore.addChangeListener(@_onChange)
		AuthAction.getUser() if @state.isAuthenticated
		PetAction.getOnePet(@state.thisPetId) if @state.thisPetId

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_onChange)
		PetStore.removeChangeListener(@_onChange)

	handleSignout: (e) ->
		e.preventDefault()
		AuthAction.signout()

	render: ->
		unless @state.isAuthenticated
			return (
				<Nav navbar right>
					<NavItem eventKey={1} href='#/signin'>Signin</NavItem>
				</Nav>
			)
		email = if @state.userData then @state.userData.email else 'no data'
		petName = if @state.thisPetData then @state.thisPetData.name else 'no data'
		<Nav navbar right>
			<p className='navbar-text'>{email}</p>
			<p className='navbar-text'>{petName}</p>
			<NavItem eventKey={1} href='#/mypets'>My pets</NavItem>
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
