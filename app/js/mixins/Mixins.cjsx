Router = require 'react-router'
AuthStore = require '../stores/AuthStore'

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

module.exports = Mixins