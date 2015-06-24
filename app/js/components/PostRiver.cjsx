React = require 'react'
PostAction = require '../actions/PostAction'
PostStore = require '../stores/PostStore'
PostList = require './PostList'
PostForm = require './PostForm'
PostModalPayload = require './PostModalPayload'
Mixins = require '../mixins/Mixins'
RB = require 'react-bootstrap'
{ Panel,Button, ButtonToolbar } = RB

getAllStoreData = ->
	postData: PostStore.getPosts()

PostRiver = React.createClass
	mixins: [Mixins.Authenticated]

	getInitialState: -> 
		stateData = getAllStoreData()
		stateData.currentPage = 1
		stateData.orderType = 'new'
		stateData

	componentDidMount: ->
		PostStore.addChangeListener(@_onChange)
		PostAction.loadPostsFromServer()

	componentWillUnmount: ->
		PostStore.removeChangeListener(@_onChange)

	handleLoadNextPage: ->
		page = @state.currentPage + 1
		@setState currentPage: page
		PostAction.loadNextPage(page)

	handleOrder: (orderType) ->
		@setState orderType: orderType
		PostAction.loadPostsFromServer(orderType)

	render: ->
		<div className='container'>
			<Panel className='pos-relative'>
				<PostForm />
			</Panel>
			<hr/>
			<ButtonToolbar>
				<Button onClick={@handleOrder.bind(@, 'created_at')}>create</Button>
				<Button onClick={@handleOrder.bind(@, 'updated_at')}>update</Button>
				<Button>hot</Button>
			</ButtonToolbar>
			<hr/>
			<PostList postData={@state.postData} />
			<Button onClick={@handleLoadNextPage}>load</Button>
			<PostModalPayload />
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = PostRiver