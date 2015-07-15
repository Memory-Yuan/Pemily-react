Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
PostAction = require '../actions/PostAction'

PostForm = React.createClass

	displayName: 'PostForm'

	mixins: [ValidationMixin]

	validatorTypes:
		title: Joi.string().required().label('Title')
		content: Joi.string().required().label('Content')

	propTypes:
		post: React.PropTypes.object

	getInitialState: ->
		if @props.post
			title: @props.post.title
			content: @props.post.content
		else
			title: ''
			content: ''

	submit: (callback) ->
		@validate (error, validationErrors) =>
			if error
				# @setState feedback: 'Form is invalid do not submit'
			else
				if @props.post
					PostAction.updatePost @_getPost()
				else
					PostAction.createPost @_getPost()
				callback() if callback
				@reset()

	reset: ->
		@setState @getInitialState()
		@clearValidations()

	_handleChange: ->
		@setState
			title: @refs.title.getDOMNode().value.trim()
			content: @refs.content.getDOMNode().value

	_getPost: ->
		title: @state.title
		content: @state.content
		id: if @props.post then @props.post.id else null

	_renderError: (field) ->
		return null if !@state.errors or $.isEmptyObject(@state.errors)
		errArr = @state.errors[field]
		if errArr.length is 0
			return null
		else
			return <span className='red-text text-lighten-1'>{errArr[0]}</span>

	render: ->
		styles =
			textarea:
				padding: '0'

		<div>
			<div className='input-field '>
				<input
					id='post_title'
					ref='title'
					type='text'
					value={@state.title}
					onChange={@_handleChange} />
		        <label htmlFor='post_title' className='active'>Title</label>
		        {@_renderError('title')}
			</div>

			<div className='input-field '>
				<textarea
					id='post_content'
					ref='content'
					value={@state.content}
					className='materialize-textarea'
					style={styles.textarea}
					onChange={@_handleChange} ></textarea>
		        <label htmlFor='post_content' className='active'>Content</label>
		        {@_renderError('content')}
			</div>
		</div>

module.exports = PostForm