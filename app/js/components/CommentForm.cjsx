Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
PostAction = require '../actions/PostAction'

CommentForm = React.createClass
	
	displayName: 'CommentForm'

	mixins: [ValidationMixin]

	propTypes:
		comment: React.PropTypes.object
		post_id: React.PropTypes.number.isRequired
		form_id: React.PropTypes.string

	validatorTypes:
		content: Joi.string().required().label('Comment')

	getValidatorData: ->
		content: @state.comment.content

	getInitialState: ->
		comment: @props.comment or {content: ''}
				

	submit: (callback) ->
		@validate (error, validationErrors) =>
			if error
				# @setState feedback: 'Form is invalid do not submit'
			else
				if @props.comment
					PostAction.updateComment @state.comment
				else
					PostAction.createComment @state.comment, @props.post_id
				callback() if callback
				@reset()

	reset: ->
		@setState @getInitialState()
		@clearValidations()

	_handleChange: ->
		@setState comment: React.addons.update(@state.comment, {
			content: {$set: @refs.comment_content.getDOMNode().value}
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
				margin: '0'
		<div>
			<div className='input-field'>
				<textarea
					id="#{@props.form_id}_content"
					ref='comment_content'
					value={@state.comment.content}
					className='materialize-textarea'
					style={styles.textarea}
					onChange={@_handleChange} />
		        <label htmlFor="#{@props.form_id}_content" className='active'>Comment</label>
		        {@_renderError('content')}
			</div>
		</div>

module.exports = CommentForm