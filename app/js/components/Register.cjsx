Router = require 'react-router'
RegisterForm = require './RegisterForm'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'
AuthStore = require '../stores/AuthStore'

Register = React.createClass

	displayName: 'Register'

	mixins: [Mixins.MooAuth, Router.Navigation, Mixins.ErrorMessage('user_register')]

	componentDidMount: ->
		AuthStore.addChangeListener(@_checkNGoNext)

	componentWillUnmount: ->
		AuthStore.removeChangeListener(@_checkAuthNNext)

	renderAlert: ->
		console.log @state.errMsg if @state.errMsg
		# if @state.errMsg
		# 	<Alert bsStyle='danger'>
		# 		{@state.errMsg}
		# 	</Alert>
		# else <span/>

	_checkNGoNext: ->
		@replaceWith('/') if AuthStore.getRegisterStatus() is 'success'

	render: ->
		wrapperStyle =
			margin: '0 auto'
			width: '60%'

		<DocumentTitle title='Register | Pemily'>
			<div className='container'>
				{@renderAlert()}
				<h1 className='center-align'>Register</h1>
				<div style={wrapperStyle}>
					<RegisterForm />
				</div>
			</div>
		</DocumentTitle>

module.exports = Register