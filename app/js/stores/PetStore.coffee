AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes
LcStorageHelp = require '../help/LcStorageHelp'

CHANGE_EVENT = 'change'

_petsData = []

_isModalOpen = false

_editIdx = -1;

_thisPetData = null

PetStore = assign({}, EventEmitter.prototype, {
	getPets: ->
		_petsData

	getModalStatus: ->
		_isModalOpen

	getEditIdx:  ->
		_editIdx

	getThisPetId: ->
		auth = LcStorageHelp.GetDataBy 'auth'
		if auth then auth.petid else null

	getThisPetData: ->
		_thisPetData

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.PET_LOADING_PETS_DATA
			console.log 'loading'
		when ActionTypes.PET_LOADED_PETS_DATA
			console.log 'loaded'
			_petsData = action.pets
			PetStore.emitChange()
		when ActionTypes.FAILED
			console.log action.err
		when ActionTypes.PET_CREATE_PREVIOUSLY
			_petsData.push action.pet
			PetStore.emitChange()
		when ActionTypes.PET_UPDATE_PREVIOUSLY
			_petsData = _petsData.map (pet) ->
				if pet.id is action.pet.id then action.pet else pet
			PetStore.emitChange()
		when ActionTypes.PET_DESTROY_PREVIOUSLY
			_petsData = _petsData.filter (ele) -> ele.id != action.pet.id
			PetStore.emitChange()
		when ActionTypes.MODAL_TRIGGER
			_isModalOpen = !_isModalOpen
			PetStore.emitChange()
		when ActionTypes.PET_NEW
			_editIdx = -1
			PetStore.emitChange()
		when ActionTypes.PET_EDIT
			_editIdx = action.idx
			PetStore.emitChange()
		when ActionTypes.PET_AS_PET
			auth = LcStorageHelp.GetDataBy 'auth'
			auth.petid = action.id
			LcStorageHelp.StoreData('auth', auth)
			PetStore.emitChange()
		when ActionTypes.PET_LOADED_ONEPET_DATA
			_thisPetData = action.pet
			PetStore.emitChange()

module.exports = PetStore