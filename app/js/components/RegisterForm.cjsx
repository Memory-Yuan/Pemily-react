React = require 'react'
Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
AuthAction = require '../actions/AuthAction'
RB = require 'react-bootstrap'
{Input, ButtonInput, Alert} = RB

RegisterForm = React.createClass
	mixins: [ValidationMixin]

	validatorTypes:
		email: Joi.string().email().required().label('User Email')
		password: Joi.string().alphanum().min(8).max(30).required().label('Password')
		password_confirmation: Joi.any().valid(Joi.ref('password')).required().options({ language: { any: { allowOnly: 'must match password' }, label: 'Password Confirmation' } })

	getInitialState: ->
		email: null
		password: null
		password_confirmation: null
		feedback: null

	handleChange: ->
		@setState
			email: @refs.email.getValue()
			password: @refs.password.getValue()
			password_confirmation: @refs.password_confirmation.getValue()

	handleSubmit: (e) ->
		e.preventDefault()

		@validate (error, validationErrors) =>
			if error
				@setState feedback: 'Form is invalid do not submit'
			else
				AuthAction.register
					email: @state.email
					password: @state.password
					password_confirmation: @state.password_confirmation
				@_reset()

	renderFeedback: ->
		if @state.feedback?
			<div className='col-xs-12'>
				<Alert bsStyle='danger'>{@state.feedback}</Alert>
			</div>
		else <span/>


	renderError: (field) ->
		errStyle =
			color: 'red'

		return @getValidationMessages(field).map (message, index)->
			<span style={errStyle} key={index}>{message}</span>

	_reset: ->
		@setState @getInitialState()
		@clearValidations()

	render: ->
		<form className='form-horizontal' onSubmit={ @handleSubmit }>
			<Input
				type='email'
				label='email'
				placeholder='email'
				labelClassName='col-xs-2'
				wrapperClassName='col-xs-10'
				ref='email'
				value={@state.email}
				onChange={@handleChange}
				required/>
			{@renderError('email')}
			<Input
				type='password'
				label='password'
				placeholder='password'
				labelClassName='col-xs-2'
				wrapperClassName='col-xs-10'
				ref='password'
				value={@state.password}
				onChange={@handleChange}
				required/>
			{@renderError('password')}
			<Input
				type='password'
				label='confirm'
				placeholder='password confirm'
				labelClassName='col-xs-2'
				wrapperClassName='col-xs-10'
				ref='password_confirmation'
				value={@state.password_confirmation}
				onChange={@handleChange}
				required/>
			{@renderError('password_confirmation')}
			<ButtonInput type='submit' value='sign in' bsStyle='primary' wrapperClassName='col-xs-offset-2 col-xs-10'/>
			{@renderFeedback()}
		</form>

module.exports = RegisterForm