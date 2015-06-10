React = require 'react'
RB = require 'react-bootstrap'
{Input, ButtonInput} = RB
PostAction = require '../actions/PostAction'

PostForm = React.createClass
	getInitialState: ->
		if @props.post
			post: @props.post
		else
			post: {title: '', content: ''}

	handleChange: ->
		post = @state.post
		post.title = @refs.postTitle.getValue()
		post.content = @refs.postContent.getValue()
		@setState post: post

	handleSubmit: (e) ->
		e.preventDefault()
		return unless (@state.post.content and @state.post.title)
		if @props.post
			PostAction.updatePost @state.post
			PostAction.triggerModal()
		else
			PostAction.createPost @state.post
			@setState post: {title: '', content: ''}

	render: ->
		<form className='form-horizontal' onSubmit={ @handleSubmit }>
			<Input
				type='text'
				placeholder='title'
				ref='postTitle'
				value={@state.post.title}
				onChange={@handleChange}
				wrapperClassName='col-xs-12'
				required />
			<Input
				type='textarea'
				placeholder='content'
				ref='postContent'
				value={@state.post.content}
				onChange={@handleChange}
				wrapperClassName='col-xs-12'
				required />
			<ButtonInput type='submit' value='Post' bsStyle='primary' className='pull-right' wrapperClassName='col-xs-12'/>
		</form>

module.exports = PostForm