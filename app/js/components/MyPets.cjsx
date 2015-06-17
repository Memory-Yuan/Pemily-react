React = require 'react'
PetAction = require '../actions/PetAction'
PetStore = require '../stores/PetStore'
PetList = require './PetList'
PetModalPayload = require './PetModalPayload'
RB = require 'react-bootstrap'
Button = RB.Button
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'

getAllStoreData = ->
	myPetsData: PetStore.getMyPets()
	isModalOpen: PetStore.getModalStatus()
	editIdx: PetStore.getEditIdx()

MyPets = React.createClass
	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PetStore.addChangeListener(@_onChange)
		PetAction.loadPetsFromServer()

	componentWillUnmount: ->
		PetStore.removeChangeListener(@_onChange)

	handleToggle: ->
		PetAction.newPet()
		PetAction.triggerModal()

	render: ->
		pet = if @state.editIdx is -1 then false else @state.myPetsData[@state.editIdx]
		<DocumentTitle title="My pets | Pemily">
			<div>
				<h1>My pets</h1>
				<PetList petsData={@state.myPetsData} />
				<Button bsStyle='primary' onClick={@handleToggle}>New</Button>
				<PetModalPayload isModalOpen={@state.isModalOpen} pet={pet} />
			</div>
		</DocumentTitle>
	_onChange: ->
		@setState getAllStoreData()

module.exports = MyPets