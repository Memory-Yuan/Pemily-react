PetAction = require '../actions/PetAction'
PetStore = require '../stores/PetStore'
FollowList = require './FollowList'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'

getAllStoreData = ->
	myFollowedPetsData: PetStore.getMyFollowedPets()

MyFollow = React.createClass

	displayName: 'MyFollow'

	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PetStore.addChangeListener(@_onChange)
		PetAction.loadFollowedPets()

	componentWillUnmount: ->
		PetStore.removeChangeListener(@_onChange)

	_onChange: ->
		@setState getAllStoreData()

	render: ->
		<DocumentTitle title="My followed pets | Pemily">
			<div className='container'>
				<h1>My followed pets</h1>
				<FollowList petsData={@state.myFollowedPetsData} />
			</div>
		</DocumentTitle>

module.exports = MyFollow