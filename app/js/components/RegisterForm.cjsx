Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
UserAction = require '../actions/UserAction'

RegisterForm = React.createClass

	displayName: 'RegisterForm'

	mixins: [ValidationMixin]

	validatorTypes:
		email: Joi.string().email().required().label('Email')
		password: Joi.string().alphanum().min(8).max(30).required().label('Password')
		password_confirmation: Joi.any().valid(Joi.ref('password')).required().options({ language: { any: { allowOnly: 'must match password' }, label: 'Password Confirmation' } })

	getInitialState: ->
		email: ''
		password: ''
		password_confirmation: ''

	_handleChange: ->
		@setState
			email: @refs.email.getDOMNode().value.trim()
			password: @refs.password.getDOMNode().value.trim()
			password_confirmation: @refs.password_confirmation.getDOMNode().value.trim()

	_handleSubmit: () ->
		@validate (error, validationErrors) =>
			if error
				console.log 'invalid'
				# @setState feedback: 'Form is invalid do not submit'
			else
				UserAction.register
					email: @state.email
					password: @state.password
					password_confirmation: @state.password_confirmation
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
				<div className='input-field'>
					<input
						id='password_confirmation'
						ref='password_confirmation'
						type='password'
						value={@state.password_confirmation}
						onChange={@_handleChange} />
			        <label htmlFor='password_confirmation'>Password Confirmation</label>
			        {@_renderError('password_confirmation')}
				</div>
			</div>
			<div className='right-align'>
				<a className='waves-effect waves-teal btn-flat' onClick={@_reset}>Reset</a>
				<a className='waves-effect waves-light btn-large' onClick={@_handleSubmit}>Submit</a>
			</div>
		</div>

module.exports = RegisterForm