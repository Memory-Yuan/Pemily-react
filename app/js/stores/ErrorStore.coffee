AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes

CHANGE_EVENT = 'change'

_errorMessage =
	signin: null
	register: null

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
		when ActionTypes.AUTH_SIGNIN_FAILED
			_errorMessage.signin = action.errMsg
			ErrorStore.emitChange()
		when ActionTypes.USER_REGISTER_FAILED
			_errorMessage.register = action.errMsg
			ErrorStore.emitChange()


module.exports = ErrorStore