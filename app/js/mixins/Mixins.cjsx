Router = require 'react-router'
AuthStore = require '../stores/AuthStore'

Mixins = 
	Authenticated:
		statics:
			willTransitionTo: (transition) ->
				transition.redirect('signin', {}, {nextPath: transition.path}) unless AuthStore.isAuthenticated()

	MooAuth:
		statics:
			willTransitionTo: (transition) ->
				transition.redirect('/', {}, {}) if AuthStore.isAuthenticated()

module.exports = Mixins