AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ApiUrl = AppConstants.APIUrl
AuthStore = require '../stores/AuthStore'

PetAction = 
	loadPetsFromServer: ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_LOADING_MYPETS_DATA
		$.ajax
			url: "#{ApiUrl}/mypets"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_MYPETS_DATA, pets: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	createPet: (pet) ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_CREATE_PREVIOUSLY, pet: pet
		$.ajax
			url: "#{ApiUrl}/mypets"
			dataType: 'json'
			type: 'POST'
			data: pet: pet
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPetsFromServer()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	updatePet: (pet) ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_UPDATE_PREVIOUSLY, pet: pet
		$.ajax
			url: "#{ApiUrl}/mypets/#{pet.id}"
			dataType: 'json'
			type: 'PUT'
			data: pet: pet
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPetsFromServer()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	destroyPet: (pet) ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_DESTROY_PREVIOUSLY, pet: pet
		$.ajax
			url: "#{ApiUrl}/mypets/#{pet.id}"
			dataType: 'json'
			type: 'DELETE'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadPetsFromServer()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	triggerModal: ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_MODAL_TRIGGER

	newPet: ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_NEW

	editPet: (idx) ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_EDIT, idx: idx

	asPet: (id) ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_AS_PET, id: id

	getSelectedPet: (id) ->
		$.ajax
			url: "#{ApiUrl}/mypets/#{id}"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_SELECTED_PET_DATA, pet: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	loadOnePet: (id) ->
		$.ajax
			url: "#{ApiUrl}/pets/#{id}"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_ONE_PET_DATA, pet: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	followPet: (id) ->
		$.ajax
			url: "#{ApiUrl}/pets/#{id}/follow"
			dataType: 'json'
			type: 'POST'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			@loadOnePet(id)
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	unfollowPet: (id, type) ->
		$.ajax
			url: "#{ApiUrl}/pets/#{id}/unfollow"
			dataType: 'json'
			type: 'DELETE'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			if type is 'profile'
				@loadOnePet(id)
			else if type is 'follow'
				@loadFollowedPets()
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

	loadFollowedPets: ->
		$.ajax
			url: "#{ApiUrl}/pets/myfollowed"
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_FOLLOWED_PET_DATA, pets: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, xhr: xhr

module.exports = PetAction