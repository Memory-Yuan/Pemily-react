AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ApiUrl = "#{AppConstants.APIUrl}/posts"
AuthStore = require '../stores/AuthStore'
PetStore = require '../stores/PetStore'
PostStore = require '../stores/PostStore'

PostAction = 
	loadPostsFromServer: (order=AppConstants.DefaultOrder, per_page=AppConstants.DefaultPerPage) ->
		$.ajax
			url: ApiUrl
			dataType: 'json'
			type: 'GET'
			data: order: order, per_page: per_page
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.POST_LOADED_POSTS_DATA, posts: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	loadPostsOfPet: (pet_id) ->
		$.ajax
			url: "#{ApiUrl}/of_pet/#{pet_id}"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.POST_LOADED_POSTS_DATA_OF_PET, posts: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	loadNextPage: (page, order) ->
		$.ajax
			url: ApiUrl
			dataType: 'json'
			type: 'GET'
			data: page: page, order: order
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.POST_LOADED_NEXT_PAGE_POSTS_DATA, posts: result, page: page
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	setOrderType: (order) ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_SET_ORDER, order: order

	createPost: (post) ->
		post.pet = PetStore.getSelectedPetData()
		AppDispatcher.dispatch actionType: ActionTypes.POST_CREATE_PREVIOUSLY, post: post
		$.ajax
			url: ApiUrl
			dataType: 'json'
			type: 'POST'
			data: 
				pet_id: PetStore.getSelectedPetId()
				post: post
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPostsFromServer(PostStore.getOrderType(), PostStore.getCurrentPage() * AppConstants.DefaultPerPage)
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	updatePost: (post) ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_UPDATE_PREVIOUSLY, post: post
		$.ajax
			url: "#{ApiUrl}/#{post.id}"
			dataType: 'json'
			type: 'PUT'
			data: 
				pet_id: PetStore.getSelectedPetId()
				post: post
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPostsFromServer(PostStore.getOrderType(), PostStore.getCurrentPage() * AppConstants.DefaultPerPage)
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	destroyPost: (post) ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_DESTROY_PREVIOUSLY, post: post
		$.ajax
			url: "#{ApiUrl}/#{post.id}"
			dataType: 'json'
			type: 'DELETE'
			data: 
				pet_id: PetStore.getSelectedPetId()
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPostsFromServer(PostStore.getOrderType(), PostStore.getCurrentPage() * AppConstants.DefaultPerPage)
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	editPost: (idx) ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_EDIT, idx: idx

	triggerModal: ->
		AppDispatcher.dispatch actionType: ActionTypes.POST_MODAL_TRIGGER

	loadCommentsFromServer: (post_id) ->
		$.ajax
			url: "#{ApiUrl}/#{post_id}/comments"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.COMMENT_LOADED_COMMENTS_DATA, comments: result, post_id: post_id
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	createComment: (comment, post_id) ->
		comment.pet = PetStore.getSelectedPetData()
		AppDispatcher.dispatch actionType: ActionTypes.COMMENT_CREATE_PREVIOUSLY, comment: comment, post_id: post_id
		$.ajax
			url: "#{ApiUrl}/#{post_id}/comments"
			dataType: 'json'
			type: 'POST'
			data: 
				pet_id: PetStore.getSelectedPetId()
				comment: comment
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadCommentsFromServer(post_id)
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	editComment: (index) ->
		AppDispatcher.dispatch actionType: ActionTypes.COMMENT_EDIT, idx: index

	updateComment: (comment) ->
		AppDispatcher.dispatch actionType: ActionTypes.COMMENT_UPDATE_PREVIOUSLY, comment: comment
		@editComment(-1)
		$.ajax
			url: "#{ApiUrl}/#{comment.post_id}/comments/#{comment.id}"
			dataType: 'json'
			type: 'PUT'
			data: 
				pet_id: PetStore.getSelectedPetId()
				comment: comment
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadCommentsFromServer(comment.post_id)
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	destroyComment: (comment) ->
		AppDispatcher.dispatch actionType: ActionTypes.COMMENT_DESTROY_PREVIOUSLY, comment: comment
		$.ajax
			url: "#{ApiUrl}/#{comment.post_id}/comments/#{comment.id}"
			dataType: 'json'
			type: 'DELETE'
			data: 
				pet_id: PetStore.getSelectedPetId()
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadCommentsFromServer(comment.post_id)
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

module.exports = PostAction