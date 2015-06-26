React = require 'react'
Router = require 'react-router'
RegisterForm = require './RegisterForm'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'
AuthStore = require '../stores/AuthStore'
RB = require 'react-bootstrap'
{Alert} = RB

Register = React.createClass
	mixins: [Mixins.MooAuth, Router.Navigation, Mixins.ErrorMessage('user_register')]

	componentDidMount: ->
		AuthStore.addChangeListener(@_checkNGoNext)

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_checkAuthNNext)

	renderAlert: ->
		if @state.errMsg
			<Alert bsStyle='danger'>
				{@state.errMsg}
			</Alert>
		else <span/>

	_checkNGoNext: ->
		@replaceWith('/') if AuthStore.getRegisterStatus() is 'success'

	render: ->
		wrapperStyle=
			margin: '0 auto'
			width: '50%'
		<DocumentTitle title="Register | Pemily">
			<div className='container'>
				{@renderAlert()}
				<h1 className='center'>Register</h1>
				<div style={wrapperStyle}>
					<RegisterForm/>
				</div>
			</div>
		</DocumentTitle>

module.exports = Register