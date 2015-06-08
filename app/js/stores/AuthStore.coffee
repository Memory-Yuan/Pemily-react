AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes
LcStorageHelp = require '../help/LcStorageHelp'

CHANGE_EVENT = 'change'

_userData = null

AuthStore = assign({}, EventEmitter.prototype, {
	isAuthenticated: ->
		if localStorage.auth then true else false

	getUserData: ->
		if @isAuthenticated() then _userData else null

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
		when ActionTypes.STORE_API_TOKEN
			LcStorageHelp.StoreData('auth', {token: action.token})
			AuthStore.emitChange()
		when ActionTypes.CLEAN_AUTH
			delete localStorage.auth;
			AuthStore.emitChange()
		when ActionTypes.LOADED_USERDATA
			_userData = action.content
			AuthStore.emitChange()
		when ActionTypes.CLEAN_USERDATA
			_userData = null
			AuthStore.emitChange()

module.exports = AuthStore