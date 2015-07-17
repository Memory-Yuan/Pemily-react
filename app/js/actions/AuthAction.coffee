AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ErrorMsgs = AppConstants.ErrorMsgs
ApiUrl = "#{AppConstants.APIUrl}/auth"
UserAction = require '../actions/UserAction'

AuthAction = 
	signin: (email, password) ->
		$.ajax
			url: "#{ApiUrl}/signin"
			dataType: 'json'
			type: 'POST'
			data: email: email, password: password
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.AUTH_STORE_API_TOKEN, token: result.token
			UserAction.getUser()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.HANDLE_FAILED, xhr: xhr, at: 'auth_signin'

	signout: ->
		AppDispatcher.dispatch actionType: ActionTypes.AUTH_CLEAN
		AppDispatcher.dispatch actionType: ActionTypes.USER_CLEAN_USER_DATA
		AppDispatcher.dispatch actionType: ActionTypes.PET_CLEAN_SELECTED_PET_DATA

module.exports = AuthAction