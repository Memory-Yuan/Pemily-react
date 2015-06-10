React = require 'react'
PostAction = require '../actions/PostAction'
PostStore = require '../stores/PostStore'
PostList = require './PostList'
PostForm = require './PostForm'
PostModalPayload = require './PostModalPayload'
Mixins = require '../mixins/Mixins'
RB = require 'react-bootstrap'
{ Panel } = RB

getAllStoreData = ->
	postData: PostStore.getPosts()

PostRiver = React.createClass
	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PostStore.addChangeListener(@_onChange)
		PostAction.loadPostsFromServer()

	componentWillUnmount: ->
		PostStore.removeChangeListener(@_onChange)

	render: ->
		<div className='col-xs-8'>
			<Panel className='pos-relative'>
				<PostForm />
			</Panel>
			<PostList postData={@state.postData} />
			<PostModalPayload />
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = PostRiver