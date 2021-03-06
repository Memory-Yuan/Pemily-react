AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes
LcStorageHelp = require '../help/LcStorageHelp'

CHANGE_EVENT = 'change'

_myPetsData = []

_selectedPetData = null

_thisPetData = null

_myFollowedPet = []

PetStore = assign({}, EventEmitter.prototype, {
	getMyPets: ->
		_myPetsData

	getSelectedPetId: ->
		auth = LcStorageHelp.GetDataBy 'auth'
		if auth then auth.petid else null

	getSelectedPetData: ->
		_selectedPetData

	isCorrectPet: (id) ->
		id? and @getSelectedPetId() == id

	getThisPetData: ->
		_thisPetData

	getMyFollowedPets: ->
		_myFollowedPet

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.PET_LOADING_MYPETS_DATA
			console.log 'loading'
		when ActionTypes.PET_LOADED_MYPETS_DATA
			console.log 'loaded'
			_myPetsData = action.pets
			PetStore.emitChange()
		when ActionTypes.PET_CREATE_PREVIOUSLY
			_myPetsData.push action.pet
			PetStore.emitChange()
		when ActionTypes.PET_UPDATE_PREVIOUSLY
			_myPetsData = _myPetsData.map (pet) ->
				if pet.id is action.pet.id then action.pet else pet
			PetStore.emitChange()
		when ActionTypes.PET_DESTROY_PREVIOUSLY
			_myPetsData = _myPetsData.filter (ele) -> ele.id != action.pet.id
			PetStore.emitChange()
		when ActionTypes.PET_AS_PET
			auth = LcStorageHelp.GetDataBy 'auth'
			auth.petid = action.id
			LcStorageHelp.StoreData('auth', auth)
			PetStore.emitChange()
		when ActionTypes.PET_LOADED_SELECTED_PET_DATA
			_selectedPetData = action.pet
			PetStore.emitChange()
		when ActionTypes.PET_LOADED_ONE_PET_DATA
			_thisPetData = action.pet
			PetStore.emitChange()
		when ActionTypes.PET_CLEAN_SELECTED_PET_DATA
			_selectedPetData = null
			PetStore.emitChange()
		when ActionTypes.PET_LOADED_FOLLOWED_PET_DATA
			_myFollowedPet = action.pets
			PetStore.emitChange()

module.exports = PetStore