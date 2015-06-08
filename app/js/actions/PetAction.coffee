AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ApiUrl = AppConstants.APIUrl + 'pets'
AuthStore = require '../stores/AuthStore'

PetAction = 
	loadPetsFromServer: ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_LOADING_PETS_DATA
		$.ajax
			url: ApiUrl
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
			# data: limit: 1
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_PETS_DATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	submitPet: (pet, type) ->
		url = ApiUrl
		url += '/' + pet.id if type is 'PUT' 
		AppDispatcher.dispatch actionType: ActionTypes.PET_CREATE_PREVIOUSLY, content: pet
		$.ajax
			url: url
			dataType: 'json'
			type: type
			data: pet: pet
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_PETS_DATA, content: result
			AppDispatcher.dispatch actionType: ActionTypes.MODAL_TRIGGER
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	destroyPet: (pet) ->
		AppDispatcher.dispatch actionType: ActionTypes.DESTROY_PET_PRE, content: pet
		$.ajax
			url: ApiUrl + '/' + pet.id
			dataType: 'json'
			type: 'DELETE'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_PETS_DATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	triggerModal: ->
		AppDispatcher.dispatch actionType: ActionTypes.MODAL_TRIGGER

	newPet: ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_NEW

	editPet: (idx) ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_EDIT, idx: idx

	asPet: (id) ->
		AppDispatcher.dispatch actionType: ActionTypes.PET_AS_PET, id: id

	getOnePet: (id) ->
		$.ajax
			url: ApiUrl + '/' + id
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.PET_LOADED_ONEPET_DATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

module.exports = PetAction