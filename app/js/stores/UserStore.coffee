AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes
LcStorageHelp = require '../help/LcStorageHelp'

CHANGE_EVENT = 'change'

_userData = null

_registerStatus = null

AuthStore = assign({}, EventEmitter.prototype, {

	getUserData: ->
		if localStorage.auth then _userData else null

	getRegisterStatus: ->
		_registerStatus

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.USER_LOADED_USER_DATA
			_userData = action.content
			AuthStore.emitChange()
		when ActionTypes.USER_CLEAN_USER_DATA
			_userData = null
			AuthStore.emitChange()
		when ActionTypes.USER_REGISTER_SUCCESS
			_registerStatus = 'success'
			AuthStore.emitChange()

module.exports = AuthStore