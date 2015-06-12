AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ApiUrl = AppConstants.APIUrl + 'posts'
AuthStore = require '../stores/AuthStore'
PetStore = require '../stores/PetStore'

PostAction = 
	loadPostsFromServer: ->
		$.ajax
			url: ApiUrl
			dataType: 'json'
			# type: 'GET'
			# data: pet_id: PetStore.getThisPetId()
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.POST_LOADED_POSTS_DATA, posts: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	createPost: (post) ->
		post.pet = PetStore.getThisPetData()
		AppDispatcher.dispatch actionType: ActionTypes.POST_CREATE_PREVIOUSLY, post: post
		$.ajax
			url: ApiUrl
			dataType: 'json'
			type: 'POST'
			data: 
				pet_id: PetStore.getThisPetId()
				post: post
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPostsFromServer()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	updatePost: (post) ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_UPDATE_PREVIOUSLY, post: post
		$.ajax
			url: ApiUrl + '/' + post.id
			dataType: 'json'
			type: 'PUT'
			data: 
				pet_id: PetStore.getThisPetId()
				post: post
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPostsFromServer()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	destroyPost: (post) ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_DESTROY_PREVIOUSLY, post: post
		$.ajax
			url: ApiUrl + '/' + post.id
			dataType: 'json'
			type: 'DELETE'
			data: 
				pet_id: PetStore.getThisPetId()
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPostsFromServer()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	editPost: (idx) ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_EDIT, idx: idx

	triggerModal: ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_MODAL_TRIGGER


module.exports = PostAction