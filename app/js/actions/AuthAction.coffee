AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ApiUrl = AppConstants.APIUrl + 'auth'

AuthAction = 
	signin: (email, password) ->
		$.ajax
			url: ApiUrl + '/signin'
			dataType: 'json'
			type: 'POST'
			data: email: email, password: password
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.STORE_API_TOKEN, token: result.token
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr
	signout: ->
		AppDispatcher.dispatch actionType: ActionTypes.CLEAN_API_TOKEN
	register: (user) ->
		$.ajax
			url: ApiUrl + '/register'
			dataType: 'json'
			type: 'POST'
			data: user: user
		.done (result) =>
			console.log 'success'
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr
	ping: ->
		$.ajax
			url: ApiUrl + '/ping'
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", localStorage.token)
		.done (result) =>
			console.log result
		.fail (xhr, status, err) =>
			# AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

module.exports = AuthAction