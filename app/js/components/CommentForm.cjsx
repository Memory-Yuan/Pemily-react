React = require 'react'
RB = require 'react-bootstrap'
{Input, ButtonInput} = RB
PostAction = require '../actions/PostAction'

CommentForm = React.createClass
	getInitialState: ->
		if @props.comment
			comment: @props.comment
		else
			comment: {content: ''}

	handleChange: ->
		comment = @state.comment
		comment.content = @refs.commentContent.getValue()
		@setState comment: comment

	handleSubmit: (e) ->
		e.preventDefault()
		return unless @state.comment.content
		if @props.comment
			PostAction.updateComment @state.comment
			# PostAction.triggerModal()
		else
			PostAction.createComment @state.comment, @props.post_id
			@setState comment: {content: ''}

	render: ->
		<form className='form-inline' onSubmit={ @handleSubmit }>
			<Input
				type='text'
				placeholder='content'
				ref='commentContent'
				value={@state.comment.content}
				onChange={@handleChange}
				required />
			<ButtonInput type='submit' value='post' bsStyle='primary'/>
		</form>

module.exports = CommentForm