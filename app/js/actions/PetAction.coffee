AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
ActionTypes = AppConstants.ActionTypes
ApiUrl = AppConstants.APIUrl + 'pets'
AuthStore = require '../stores/AuthStore'

PetAction = 
	loadPetsFromServer: ->
		AppDispatcher.dispatch actionType: ActionTypes.LOADING_PETSDATA
		$.ajax
			url: ApiUrl
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
			# data: limit: 1
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.LOADED_PETSDATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	submitPet: (pet, type) ->
		url = ApiUrl
		url += '/' + pet.id if type is 'PUT' 
		AppDispatcher.dispatch actionType: ActionTypes.CREACT_PET_PRE, content: pet
		$.ajax
			url: url
			dataType: 'json'
			type: type
			data: pet: pet
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.LOADED_PETSDATA, content: result
			AppDispatcher.dispatch actionType: ActionTypes.TRIGGER_MODAL
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
			AppDispatcher.dispatch actionType: ActionTypes.LOADED_PETSDATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

	triggerModal: ->
		AppDispatcher.dispatch actionType: ActionTypes.TRIGGER_MODAL

	newPet: ->
		AppDispatcher.dispatch actionType: ActionTypes.NEW_PET

	editPet: (idx) ->
		AppDispatcher.dispatch actionType: ActionTypes.EDIT_PET, idx: idx

	asPet: (id) ->
		AppDispatcher.dispatch actionType: ActionTypes.AS_PET, id: id

	getOnePet: (id) ->
		$.ajax
			url: ApiUrl + '/' + id
			dataType: 'json'
			beforeSend: (xhr) ->
				xhr.setRequestHeader("Authorization", AuthStore.getToken())
		.done (result) =>
			AppDispatcher.dispatch actionType: ActionTypes.LOADED_ONEPETDATA, content: result
		.fail (xhr, status, err) =>
			AppDispatcher.dispatch actionType: ActionTypes.FAILED, err: xhr

module.exports = PetAction