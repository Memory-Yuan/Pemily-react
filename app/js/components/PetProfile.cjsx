React = require 'react'
Router = require 'react-router'
{ RouteHandler } = Router
RB = require 'react-bootstrap'
{ Nav, NavItem, Button } = RB
PetStore = require '../stores/PetStore'
PetAction = require '../actions/PetAction'
PostStore = require '../stores/PostStore'
PostAction = require '../actions/PostAction'


getAllStoreData = ->
	thisPetData: PetStore.getThisPetData()
	postsOfPet: PostStore.getPostsOfPet()

PetProfile = React.createClass
	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PetStore.addChangeListener(@_onChange)
		PostStore.addChangeListener(@_onChange)
		PetAction.loadOnePet(@props.params.id)
		PostAction.loadPostsOfPet(@props.params.id)

	componentWillUnmount: ->
		PetStore.removeChangeListener(@_onChange)
		PostStore.removeChangeListener(@_onChange)

	render: ->
		return <span/> unless @state.thisPetData

		navStyle =
			marginBottom: '20px'

		<div>
			<div className='cover'></div>
			<div className='container'>
				<div>訂閱人數: {@state.thisPetData.followers_count}</div>
				<RouteHandler pet={@state.thisPetData} posts={@state.postsOfPet}/>
			</div>
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = PetProfile