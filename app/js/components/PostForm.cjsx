Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
PostAction = require '../actions/PostAction'

PostForm = React.createClass

	displayName: 'PostForm'

	mixins: [ValidationMixin]

	propTypes:
		post: React.PropTypes.object

	validatorTypes:
		title: Joi.string().required().label('Title')
		content: Joi.string().required().label('Content')

	getValidatorData: ->
		title: @state.post.title
		content: @state.post.content

	getInitialState: ->
		post: @props.post or {title: '', content: ''}

	submit: (callback) ->
		@validate (error, validationErrors) =>
			if error
				# @setState feedback: 'Form is invalid do not submit'
			else
				if @props.post
					PostAction.updatePost @state.post
				else
					PostAction.createPost @state.post
				callback() if callback
				@reset()

	reset: ->
		@setState @getInitialState()
		@clearValidations()

	_handleChange: ->
		@setState post: React.addons.update(@state.post, {
			title: {$set: @refs.post_title.getDOMNode().value.trim()}
			content: {$set: @refs.post_content.getDOMNode().value}
		})

	_renderError: (field) ->
		return null if !@state.errors or $.isEmptyObject(@state.errors) or !@state.errors[field]
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
					ref='post_title'
					type='text'
					value={@state.post.title}
					onChange={@_handleChange} />
		        <label htmlFor='post_title' className='active'>Title</label>
		        {@_renderError('title')}
			</div>

			<div className='input-field '>
				<textarea
					id='post_content'
					ref='post_content'
					value={@state.post.content}
					className='materialize-textarea'
					style={styles.textarea}
					onChange={@_handleChange} ></textarea>
		        <label htmlFor='post_content' className='active'>Content</label>
		        {@_renderError('content')}
			</div>
		</div>

module.exports = PostForm