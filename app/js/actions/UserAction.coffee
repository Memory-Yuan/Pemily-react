AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ErrorMsgs = AppConstants.ErrorMsgs
ApiUrl = "#{AppConstants.APIUrl}/users"
AuthStore = require '../stores/AuthStore'

UserAction = 
	register: (user) ->
		$.ajax
			url: "#{ApiUrl}/register"
			dataType: 'json'
			type: 'POST'
			data: user: user
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.USER_REGISTER_SUCCESS
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.HANDLE_FAILED, xhr: xhr, at: 'user_register'

	getUser: ->
		$.ajax
			url: "#{ApiUrl}/user_data"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.USER_LOADED_USER_DATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

module.exports = UserAction