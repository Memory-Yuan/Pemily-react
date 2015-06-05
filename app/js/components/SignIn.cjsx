React = require 'react'
Router = require 'react-router'
SigninForm = require './SigninForm'
AuthStore = require '../stores/AuthStore'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'

Signin = React.createClass
	mixins: [Router.State, Router.Navigation, Mixins.MooAuth]

	getInitialState: ->
		nextPath: @getQuery().nextPath

	componentDidMount: ->
		AuthStore.addChangeListener(@_checkAuthNNext)

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_checkAuthNNext)

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
			<div>
				<h1 className='center'>Signin</h1>
				<div style={wrapperStyle}>
					<SigninForm/>
					<a href='#/register'>註冊</a>
				</div>
			</div>
		</DocumentTitle>

module.exports = Signin