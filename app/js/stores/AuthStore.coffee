AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes

CHANGE_EVENT = 'change'

_userData = null

AuthStore = assign({}, EventEmitter.prototype, {
	isAuthenticated: ->
		if localStorage.token then true else false		

	getUserData: ->
		if @isAuthenticated then _userData else null

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
			localStorage.token = action.token
			AuthStore.emitChange()
		when ActionTypes.CLEAN_API_TOKEN
			delete localStorage.token;
			AuthStore.emitChange()
		when ActionTypes.LOADED_USERDATA
			_userData = action.content
			AuthStore.emitChange()
		when ActionTypes.CLEAN_USERDATA
			_userData = null
			AuthStore.emitChange()

module.exports = AuthStore