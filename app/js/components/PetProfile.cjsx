React = require 'react'
Router = require 'react-router'
{ RouteHandler } = Router
RB = require 'react-bootstrap'
{ Nav, NavItem, Button } = RB
PetStore = require '../stores/PetStore'
PetAction = require '../actions/PetAction'
PostStore = require '../stores/PostStore'
PostAction = require '../actions/PostAction'
Mixins = require '../mixins/Mixins'

getAllStoreData = ->
	thisPetData: PetStore.getThisPetData()
	postsOfPet: PostStore.getPostsOfPet()

PetProfile = React.createClass
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

	render: ->
		return <span/> unless @state.thisPetData

		navStyle =
			marginBottom: '20px'

		followBtn =
			if !@props.userData or @state.thisPetData.user_id is @props.userData.id
				<span/>
			else if @state.thisPetData.is_followed
				<Button onClick={@handleUnfollow}>已訂閱</Button>
			else
				<Button onClick={@handleFollow}>訂閱</Button>

		<div>
			<div className='cover'></div>
			<div className='container'>
				<div>
					{followBtn}
					訂閱人數: {@state.thisPetData.followers_count}
				</div>
				<RouteHandler pet={@state.thisPetData} posts={@state.postsOfPet}/>
			</div>
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = PetProfile