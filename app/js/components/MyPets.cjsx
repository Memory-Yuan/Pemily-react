PetAction = require '../actions/PetAction'
PetStore = require '../stores/PetStore'
PetList = require './PetList'
PetModal = require './PetModal'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'

getAllStoreData = ->
	myPetsData: PetStore.getMyPets()

MyPets = React.createClass

	displayName: 'MyPets'

	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PetStore.addChangeListener(@_onChange)
		PetAction.loadPetsFromServer()

	componentWillUnmount: ->
		PetStore.removeChangeListener(@_onChange)

	_newPet: ->
		@refs.petModal.trigger()

	_onChange: ->
		@setState getAllStoreData()

	render: ->
		<DocumentTitle title='My pets | Pemily'>
			<div className='container'>
				<h1 className='center-align'>My pets</h1>
				<a className='waves-effect waves-light btn' onClick={@_newPet}>New</a>
				<PetList petsData={@state.myPetsData} />
				<PetModal m_id='pet_new_modal' m_title='New pet' ref='petModal' />
			</div>
		</DocumentTitle>

module.exports = MyPets