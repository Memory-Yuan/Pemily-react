Router = require 'react-router'
AuthStore = require '../stores/AuthStore'
ErrorStore = require '../stores/ErrorStore'
{ APIBase } = require '../constants/AppConstants'

Mixins = 
	Authenticated:
		mixins: [Router.Navigation]

		componentDidMount: ->
			AuthStore.addChangeListener(@_gobackToRoot)

		componentWillUnmount: ->
			AuthStore.removeChangeListener(@_gobackToRoot)

		_gobackToRoot: ->
			@replaceWith('signin') unless AuthStore.isAuthenticated()

		statics:
			willTransitionTo: (transition) ->
				transition.redirect('signin', {}, {nextPath: transition.path}) unless AuthStore.isAuthenticated()

	MooAuth:
		statics:
			willTransitionTo: (transition) ->
				transition.redirect('/', {}, {}) if AuthStore.isAuthenticated()

	ErrorMessage: (type) ->

		getInitialState: ->
			errMsg: ''

		componentDidMount: ->
			ErrorStore.addChangeListener(@_onErrorMsgChange)

		componentWillUnmount: ->
			ErrorStore.removeChangeListener(@_onErrorMsgChange)

		_onErrorMsgChange: ->
			@setState errMsg: ErrorStore.getErrorMessage(type)

	ApiResource:
		addApiUrl: (url="") ->
			APIBase + url


module.exports = Mixins