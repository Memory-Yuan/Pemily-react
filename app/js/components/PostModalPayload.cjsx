React = require 'react'
PostAction = require '../actions/PostAction'
PostForm = require './PostForm'
RB = require 'react-bootstrap'
{ Modal, Button } = RB

PostModalPayload = React.createClass
	handleToggle: ->
		PostAction.triggerModal()

	render: ->
		return <span/> unless @props.isModalOpen

		<Modal {...@props} title='Edit' onRequestHide={@handleToggle}>
			<div className='modal-body'>
				<PostForm post={@props.editPost} />
			</div>
			<div className='modal-footer'>
				<Button onClick={@handleToggle}>Close</Button>
			</div>
		</Modal>

module.exports = PostModalPayload