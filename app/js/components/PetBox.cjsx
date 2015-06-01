# @cjsx React.DOM
React = require 'react'
PetAction = require '../actions/PetAction'
PetStore = require '../stores/PetStore'
PetList = require './PetList'
PetModalPayload = require './PetModalPayload'
RB = require 'react-bootstrap'
Button = RB.Button
DocumentTitle = require 'react-document-title'

getAllStoreData = ()->
	petsData: PetStore.getPets()
	isModalOpen: PetStore.getModalStatus()
	editIdx: PetStore.getEditIdx()

PetBox = React.createClass
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
		pet = if @state.editIdx is -1 then false else @state.petsData[@state.editIdx]
		<DocumentTitle title="My pets | Pemily">
			<div className='pet-box'>
				<h1>My pets</h1>
				<PetList petsData={@state.petsData} />
				<Button bsStyle='primary' onClick={@handleToggle}>New</Button>
				<PetModalPayload isModalOpen={@state.isModalOpen} pet={pet} />
			</div>
		</DocumentTitle>
	_onChange: ->
		@setState getAllStoreData()

module.exports = PetBox