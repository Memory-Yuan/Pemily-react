UserAction = require '../actions/UserAction'
PetAction = require '../actions/PetAction'
UserStore = require '../stores/UserStore'
AuthStore = require '../stores/AuthStore'
PetStore = require '../stores/PetStore'

getAllStoreData = ->
	isAuthenticated: AuthStore.isAuthenticated()
	userData: UserStore.getUserData()
	selectedPetId: PetStore.getSelectedPetId()
	selectedPetData: PetStore.getSelectedPetData()

GlobalContainer = React.createClass

	displayName: 'GlobalContainer'

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		UserStore.addChangeListener(@_onChange)
		AuthStore.addChangeListener(@_onChange)
		PetStore.addChangeListener(@_onChange)
		UserAction.getUser() if @state.isAuthenticated
		PetAction.getSelectedPet(@state.selectedPetId) if @state.selectedPetId

	componentWillUnmount: ->
		UserStore.removeChangeListener(@_onChange)
		AuthStore.removeChangeListener(@_onChange)
		PetStore.removeChangeListener(@_onChange)

	renderChild: ->
		React.Children.map(@props.children, (child)=>
			React.cloneElement(child, @state)
		)

	_onChange: ->
		@setState getAllStoreData()

	render: ->
		<div>
			{@renderChild()}
		</div>

module.exports = GlobalContainer
