Router = require 'react-router'
SigninForm = require './SigninForm'
AuthStore = require '../stores/AuthStore'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'

Signin = React.createClass

	displayName: 'Signin'

	mixins: [Router.State, Router.Navigation, Mixins.MooAuth, Mixins.ErrorMessage('auth_signin')]

	getInitialState: ->
		nextPath: @getQuery().nextPath

	componentDidMount: ->
		AuthStore.addChangeListener(@_checkAuthNNext)

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_checkAuthNNext)

	renderAlert: ->
		console.log @state.errMsg if @state.errMsg
		# if @state.errMsg
		# 	<Alert bsStyle='danger'>
		# 		{@state.errMsg}
		# 	</Alert>
		# else <span/>

	_checkAuthNNext: ->
		@_gotoNextPath() if AuthStore.isAuthenticated()

	_gotoNextPath: ->
		if @state.nextPath
			@replaceWith(@state.nextPath)
		else
			@replaceWith('/')

	render: ->
		wrapperStyle =
			margin: '0 auto'
			width: '60%'

		<DocumentTitle title='Signin | Pemily'>
			<div className='container'>
				{@renderAlert()}
				<h1 className='center-align'>Signin</h1>
				<div style={wrapperStyle}>
					<SigninForm />
				</div>
			</div>
		</DocumentTitle>

module.exports = Signin