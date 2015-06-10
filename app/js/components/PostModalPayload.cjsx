React = require 'react'
PostAction = require '../actions/PostAction'
PostStore = require '../stores/PostStore'
PostForm = require './PostForm'
RB = require 'react-bootstrap'
{ Modal, Button } = RB

getAllStoreData = ->
	isModalOpen: PostStore.getModalStatus()
	editPost: PostStore.getEditPost()

PostModalPayload = React.createClass
	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PostStore.addChangeListener(@_onChange)

	componentWillUnmount: ->
		PostStore.removeChangeListener(@_onChange)

	handleToggle: ->
		PostAction.triggerModal()

	render: ->
		return <span/> unless @state.isModalOpen

		<Modal {...@props} title='Edit' onRequestHide={@handleToggle}>
			<div className='modal-body'>
				<PostForm post={@state.editPost} />
			</div>
			<div className='modal-footer'>
				<Button onClick={@handleToggle}>Close</Button>
			</div>
		</Modal>

	_onChange: ->
		@setState getAllStoreData()

module.exports = PostModalPayload