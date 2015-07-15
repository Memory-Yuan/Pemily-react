{ RouteHandler } = require 'react-router'
PetStore = require '../stores/PetStore'
PetAction = require '../actions/PetAction'
PostStore = require '../stores/PostStore'
PostAction = require '../actions/PostAction'
Mixins = require '../mixins/Mixins'

getAllStoreData = ->
	thisPetData: PetStore.getThisPetData()
	postsOfPet: PostStore.getPostsOfPet()

PetProfile = React.createClass

	displayName: 'PetProfile'

	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PetStore.addChangeListener(@_onChange)
		PostStore.addChangeListener(@_onChange)
		PetAction.loadOnePet(@props.params.id)
		PostAction.loadPostsOfPet(@props.params.id)

	componentWillUnmount: ->
		PetStore.removeChangeListener(@_onChange)
		PostStore.removeChangeListener(@_onChange)

	handleFollow: ->
		PetAction.followPet @state.thisPetData.id

	handleUnfollow: ->
		PetAction.unfollowPet @state.thisPetData.id, 'profile'

	_onChange: ->
		@setState getAllStoreData()

	render: ->
		return <span/> unless @state.thisPetData

		followBtn =
			if !@props.userData or @state.thisPetData.user_id is @props.userData.id
				<span/>
			else if @state.thisPetData.is_followed
				<a className='waves-effect waves-light btn' onClick={@handleUnfollow}>已訂閱</a>
			else
				<a className='waves-effect btn white black-text' onClick={@handleFollow}>訂閱</a>

		<div>
			<main className='cover orange'></main>
			<div className='container'>
				<div>
					{followBtn}
					訂閱人數: {@state.thisPetData.followers_count}
				</div>
				<RouteHandler pet={@state.thisPetData} posts={@state.postsOfPet}/>
			</div>
		</div>

module.exports = PetProfile