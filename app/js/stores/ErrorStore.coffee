AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes

CHANGE_EVENT = 'change'

_errorMessage =
	auth_signin: null
	user_register: null

_parseMessage = (xhr) ->
	return 'Service Unavailable' if xhr.status is 0
	jmsg = JSON.parse(xhr.responseText)
	if jmsg.error
		jmsg.error
	else
		'unknown error'

ErrorStore = assign({}, EventEmitter.prototype, {

	getErrorMessage: (name) ->
		unless name?
			_errorMessage
		else
			msg = _errorMessage[name]
			_errorMessage[name] = null
			msg

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.HANDLE_FAILED
			_errorMessage[action.at] = _parseMessage(action.xhr)
			ErrorStore.emitChange()
		when ActionTypes.FAILED
			console.log action.err


module.exports = ErrorStore