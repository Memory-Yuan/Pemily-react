AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes

CHANGE_EVENT = 'change'

_petsData = []

_isModalOpen = false

_editIdx = -1;

PetStore = assign({}, EventEmitter.prototype, {
	getPets: ->
		_petsData

	getModalStatus: ->
		_isModalOpen

	getEditIdx:  ->
		_editIdx

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.LOADING_PETSDATA
			console.log 'loading'
		when ActionTypes.LOADED_PETSDATA
			console.log 'loaded'
			_petsData = action.content
			PetStore.emitChange()
		when ActionTypes.FAILED
			console.log action.err
		when ActionTypes.CREACT_PET_PRE
			_petsData = _petsData.concat [action.content]
			PetStore.emitChange()
		when ActionTypes.DESTROY_PET_PRE
			_petsData = _petsData.filter (ele) -> ele.id != action.content.id
			PetStore.emitChange()
		when ActionTypes.TRIGGER_MODAL
			_isModalOpen = !_isModalOpen
			PetStore.emitChange()
		when ActionTypes.NEW_PET
			_editIdx = -1
			PetStore.emitChange()
		when ActionTypes.EDIT_PET
			_editIdx = action.idx
			PetStore.emitChange()

module.exports = PetStore