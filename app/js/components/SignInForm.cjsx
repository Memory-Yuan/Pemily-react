Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
AuthAction = require '../actions/AuthAction'

SigninForm = React.createClass

	displayName: 'SignInForm'

	mixins: [ValidationMixin]

	validatorTypes:
		email: Joi.string().email().required().label('Email')
		password: Joi.string().alphanum().min(8).max(30).required().label('Password')

	getInitialState: ->
		email: ''
		password: ''

	_handleChange: ->
		@setState
			email: @refs.email.getDOMNode().value.trim()
			password: @refs.password.getDOMNode().value.trim()

	_handleSubmit: ->
		@validate (error, validationErrors) =>
			if error
				console.log 'invalid'
				# @setState feedback: 'Form is invalid do not submit'
			else
				AuthAction.signin @state.email, @state.password
				@_reset()

	_reset: ->
		@setState @getInitialState()
		@clearValidations()

	_renderError: (field) ->
		return null if !@state.errors or $.isEmptyObject(@state.errors)
		errArr = @state.errors[field]
		if errArr.length is 0
			return null
		else
			return <span className='red-text text-lighten-1'>{errArr[0]}</span>

	render: ->
		<div>
			<div>
				<div className='input-field '>
					<input
						id='email'
						ref='email'
						type='email'
						value={@state.email}
						onChange={@_handleChange} />
			        <label htmlFor='email'>Email</label>
			        {@_renderError('email')}
				</div>
				<div className='input-field'>
					<input
						id='password'
						ref='password'
						type='password'
						value={@state.password}
						onChange={@_handleChange} />
			        <label htmlFor='password'>Password</label>
			        {@_renderError('password')}
				</div>
			</div>
			<div className='right-align'>
				<a href='#/register' className='waves-effect waves-teal btn-flat'>Register</a>
				<a className='waves-effect waves-light btn-large' onClick={@_handleSubmit}>Submit</a>
			</div>
		</div>

module.exports = SigninForm