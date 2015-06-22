AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ApiUrl = "#{AppConstants.APIUrl}/auth"
AuthStore = require '../stores/AuthStore'

AuthAction = 
	signin: (email, password) ->
		$.ajax
			url: "#{ApiUrl}/signin"
			dataType: 'json'
			type: 'POST'
			data: email: email, password: password
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.AUTH_STORE_API_TOKEN, token: result.token
			@getUser()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	signout: ->
		AppDispatcher.dispatch actionType: ActionTypes.AUTH_CLEAN
		AppDispatcher.dispatch actionType: ActionTypes.USER_CLEAN_USER_DATA
		AppDispatcher.dispatch actionType: ActionTypes.PET_CLEAN_SELECTED_PET_DATA

	ping: ->
		$.ajax
			url: "#{ApiUrl}/ping"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			console.log result
		.fail (xhr, status, err) =>
			# AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	register: (user) ->
		$.ajax
			url: "#{ApiUrl}/register"
			dataType: 'json'
			type: 'POST'
			data: user: user
		.done (result) =>
			console.log 'success'
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	getUser: ->
		$.ajax
			url: "#{ApiUrl}/user_data"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
			# data: limit: 1
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.USER_LOADED_USER_DATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

module.exports = AuthAction