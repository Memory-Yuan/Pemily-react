AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes
LcStorageHelp = require '../help/LcStorageHelp'

CHANGE_EVENT = 'change'

AuthStore = assign({}, EventEmitter.prototype, {
	isAuthenticated: ->
		if localStorage.auth then true else false

	getToken: ->
		auth = LcStorageHelp.GetDataBy 'auth'
		if auth then auth.token else false

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.AUTH_STORE_API_TOKEN
			LcStorageHelp.StoreData('auth', {token: action.token})
			AuthStore.emitChange()
		when ActionTypes.AUTH_CLEAN
			delete localStorage.auth;
			AuthStore.emitChange()

module.exports = AuthStore