React = require 'react'
Router = require 'react-router'
SigninForm = require './SigninForm'
AuthStore = require '../stores/AuthStore'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'
RB = require 'react-bootstrap'
{Alert} = RB

Signin = React.createClass
	mixins: [Router.State, Router.Navigation, Mixins.MooAuth, Mixins.ErrorMessage('signin')]

	getInitialState: ->
		nextPath: @getQuery().nextPath

	componentDidMount: ->
		AuthStore.addChangeListener(@_checkAuthNNext)

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_checkAuthNNext)

	renderAlert: ->
		if @state.errMsg
			<Alert bsStyle='danger'>
				{@state.errMsg}
			</Alert>
		else <span/>

	_checkAuthNNext: ->
		@_gotoNextPath() if AuthStore.isAuthenticated()

	_gotoNextPath: ->
		if @state.nextPath
			@replaceWith(@state.nextPath)
		else
			@replaceWith('/')

	render: ->
		wrapperStyle=
			margin: '0 auto'
			width: '50%'

		<DocumentTitle title="Signin | Pemily">
			<div className='container'>
				{@renderAlert()}
				<h1 className='center'>Signin</h1>
				<div style={wrapperStyle}>
					<SigninForm/>
					<a href='#/register'>註冊</a>
				</div>
			</div>
		</DocumentTitle>

module.exports = Signin