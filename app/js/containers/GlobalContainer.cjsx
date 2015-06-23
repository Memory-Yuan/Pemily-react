React = require 'react'
AuthAction = require '../actions/AuthAction'
AuthStore = require '../stores/AuthStore'
PetAction = require '../actions/PetAction'
PetStore = require '../stores/PetStore'

getAllStoreData = ->
	isAuthenticated: AuthStore.isAuthenticated()
	userData: AuthStore.getUserData()
	selectedPetId: PetStore.getSelectedPetId()
	selectedPetData: PetStore.getSelectedPetData()

GlobalContainer = React.createClass
	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		AuthStore.addChangeListener(@_onChange)
		PetStore.addChangeListener(@_onChange)
		AuthAction.getUser() if @state.isAuthenticated
		PetAction.getSelectedPet(@state.selectedPetId) if @state.selectedPetId

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_onChange)
		PetStore.removeChangeListener(@_onChange)

	renderChild: ->
		React.Children.map(@props.children, (child)=>
			React.cloneElement(child, @state)
		)

	render: ->
		<div>
			{@renderChild()}
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = GlobalContainer
