AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes

CHANGE_EVENT = 'change'

AuthStore = assign({}, EventEmitter.prototype, {
	isSignin: ->
		if localStorage.stext then true else false

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.STORE_API_TOKEN
			localStorage.stext = action.token
			console.log action.token
		when ActionTypes.CLEAN_API_TOKEN
			localStorage.clear("stext");
		when ActionTypes.FAILED
			console.log action.err

	AuthStore.emitChange()

module.exports = AuthStore