React = require 'react'
Router = require 'react-router'
{ RouteHandler } = Router
RB = require 'react-bootstrap'
{ Nav, NavItem } = RB
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
				<Nav style={navStyle} bsStyle='pills' activeKey={1}>
					<NavItem eventKey={1} href='/home'>關注</NavItem>
					<NavItem eventKey={2} title='Item'>NavItem 2 content</NavItem>
					<NavItem eventKey={3} disabled={true}>NavItem 3 content</NavItem>
				</Nav>
				<RouteHandler pet={@state.thisPetData} posts={@state.postsOfPet}/>
			</div>
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = PetProfile