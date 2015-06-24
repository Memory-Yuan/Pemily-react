React = require 'react'
PostAction = require '../actions/PostAction'
PostStore = require '../stores/PostStore'
PostList = require './PostList'
PostForm = require './PostForm'
PostModalPayload = require './PostModalPayload'
Mixins = require '../mixins/Mixins'
RB = require 'react-bootstrap'
{ Panel,Button, ButtonToolbar } = RB
AppConstants = require '../constants/AppConstants'

getAllStoreData = ->
	postData: PostStore.getPosts()
	isModalOpen: PostStore.getModalStatus()
	editPost: PostStore.getEditPost()
	currentPage: PostStore.getCurrentPage()
	orderType: PostStore.getOrderType()

PostRiver = React.createClass
	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PostStore.addChangeListener(@_onChange)
		PostAction.loadPostsFromServer()

	componentWillUnmount: ->
		PostStore.removeChangeListener(@_onChange)

	handleLoadNextPage: ->
		PostAction.loadNextPage(@state.currentPage + 1, @state.orderType)

	handleOrder: (orderType) ->
		PostAction.loadPostsFromServer(orderType, @state.currentPage * AppConstants.DefaultPerPage)
		PostAction.setOrderType(orderType)

	render: ->
		<div className='container'>
			<Panel className='pos-relative'>
				<PostForm />
			</Panel>
			<hr/>
			<span>order by: {@state.orderType}</span>
			<ButtonToolbar>
				<Button onClick={@handleOrder.bind(@, 'created_at')}>create</Button>
				<Button onClick={@handleOrder.bind(@, 'updated_at')}>update</Button>
				<Button>hot</Button>
			</ButtonToolbar>
			<hr/>
			<PostList postData={@state.postData} />
			<Button onClick={@handleLoadNextPage}>load</Button>
			<span>page: {@state.currentPage}</span>
			<PostModalPayload isModalOpen={@state.isModalOpen} editPost={@state.editPost} />
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = PostRiver