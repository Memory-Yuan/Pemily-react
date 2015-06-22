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
	selectedPetId: PetStore.getSelectedPetId()
	selectedPetData: PetStore.getSelectedPetData()

HeaderSignined = React.createClass
	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		AuthStore.addChangeListener(@_onChange)
		PetStore.addChangeListener(@_onChange)
		AuthAction.getUser() if @state.isAuthenticated
		PetAction.getSelectedPet(@state.selectedPetId) if @state.selectedPetId

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
		if @state.selectedPetData
			petName = @state.selectedPetData.name
			petUrl = "#/mypets/#{@state.selectedPetData.id}"
		else
			petName = 'no data'
			petUrl = '#'

		<Nav navbar right>
			<NavItem eventKey={1} href='#'>{email}</NavItem>
			<NavItem eventKey={2} href={petUrl}>{petName}</NavItem>
			<DropdownButton eventKey={3} title={<i className='glyphicon glyphicon-cog'></i>}>
				<MenuItem eventKey='1' href='#/mypets'>My Pets</MenuItem>
				<MenuItem eventKey='2' href='#/channel'>My Channel</MenuItem>
				<MenuItem eventKey='3' href='#/follow'>My Subscription</MenuItem>
				<MenuItem divider />
				<MenuItem eventKey='4' onClick={ @handleSignout }>Signout</MenuItem>
			</DropdownButton>
		</Nav>

	_onChange: ->
		@setState getAllStoreData()

module.exports = HeaderSignined
