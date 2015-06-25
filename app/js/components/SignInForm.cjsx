React = require 'react'
AuthAction = require '../actions/AuthAction'
RB = require 'react-bootstrap'
{Input, ButtonInput} = RB

SigninForm = React.createClass
	getInitialState: ->
		email: ''
		password: ''

	handleChange: ->
		@setState
			email: @refs.email.getValue()
			password: @refs.password.getValue()

	handleSubmit: (e) ->
		e.preventDefault()
		AuthAction.signin @state.email, @state.password
		@setState email: '', password: ''

	render: ->
		btnStyle=
			height: '80px'
			width: '80px'
		<form className='form-horizontal' onSubmit={ @handleSubmit }>
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
			</div>
			<div className='col-xs-2'>
				<ButtonInput type='submit' value='sign in' bsStyle='primary' style={btnStyle}/>
			</div>
		</form>

module.exports = SigninForm