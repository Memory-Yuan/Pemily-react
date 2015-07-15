Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
PostAction = require '../actions/PostAction'

CommentForm = React.createClass
	
	displayName: 'CommentForm'

	mixins: [ValidationMixin]

	validatorTypes:
		comment: Joi.string().required().label('Comment')

	propTypes:
		comment: React.PropTypes.object
		post_id: React.PropTypes.number.isRequired
		form_id: React.PropTypes.string

	getInitialState: ->
		if @props.comment
			comment: @props.comment.content
		else
			comment: ''

	submit: (callback) ->
		@validate (error, validationErrors) =>
			if error
				# @setState feedback: 'Form is invalid do not submit'
			else
				if @props.comment
					PostAction.updateComment @_getComment()
				else
					PostAction.createComment @_getComment(), @props.post_id
				callback() if callback
				@reset()

	reset: ->
		@setState @getInitialState()
		@clearValidations()

	_handleChange: ->
		@setState comment: @refs.comment.getDOMNode().value

	_getComment: ->
		content: @state.comment
		id: if @props.comment then @props.comment.id else null
		post_id: if @props.comment then @props.post_id else null

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
				margin: '0'
		<div>
			<div className='input-field'>
				<textarea
					id="#{@props.form_id}_content"
					ref='comment'
					value={@state.comment}
					className='materialize-textarea'
					style={styles.textarea}
					onChange={@_handleChange} />
		        <label htmlFor="#{@props.form_id}_content" className='active'>Comment</label>
		        {@_renderError('comment')}
			</div>
		</div>

module.exports = CommentForm