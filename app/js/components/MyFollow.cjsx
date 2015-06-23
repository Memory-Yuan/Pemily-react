React = require 'react'
PetAction = require '../actions/PetAction'
PetStore = require '../stores/PetStore'
PetList = require './PetList'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'

getAllStoreData = ->
	myFollowedPetsData: PetStore.getMyFollowedPets()

MyFollow = React.createClass
	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PetStore.addChangeListener(@_onChange)
		PetAction.loadFollowedPets()

	componentWillUnmount: ->
		PetStore.removeChangeListener(@_onChange)

	render: ->
		<DocumentTitle title="My followed pets | Pemily">
			<div>
				<h1>My followed pets</h1>
				<PetList petsData={@state.myFollowedPetsData} nodeType='follow' />
			</div>
		</DocumentTitle>
	_onChange: ->
		@setState getAllStoreData()

module.exports = MyFollow