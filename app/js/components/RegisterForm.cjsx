React = require 'react'
AuthAction = require '../actions/AuthAction'
RB = require 'react-bootstrap'
Input = RB.Input

RegisterForm = React.createClass
	getInitialState: ->
		email: ''
		password: ''
		password_confirmation: ''

	handleChange: ->
		@setState
			email: @refs.email.getValue()
			password: @refs.password.getValue()
			password_confirmation: @refs.password_confirmation.getValue()

	handleSubmit: (e) ->
		e.preventDefault()
		AuthAction.register
			email: @state.email
			password: @state.password
			password_confirmation: @state.password_confirmation

	render: ->
		btnStyle=
			height: '80px'
			width: '80px'
		<form className='register-form form-horizontal' onSubmit={ @handleSubmit }>
			<div className='col-xs-10'>
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
			</div>
			<div className='col-xs-2'>
				<Input type='submit' value='sign in' bsStyle='primary' style={btnStyle}/>
			</div>
		</form>

module.exports = RegisterForm