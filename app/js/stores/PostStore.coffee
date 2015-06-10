AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require('events').EventEmitter
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes
LcStorageHelp = require '../help/LcStorageHelp'

CHANGE_EVENT = 'change'

_postData = []

_editIdx = null

_isModalOpen = false

PostStore = assign({}, EventEmitter.prototype, {
	getPosts: ->
		_postData

	getEditPost: ->
		_postData[_editIdx] if _editIdx?

	getModalStatus: ->
		_isModalOpen

	emitChange: ->
		@emit(CHANGE_EVENT)

	addChangeListener: (callback) -> 
		@on(CHANGE_EVENT, callback)

	removeChangeListener: (callback) -> 
		@removeListener(CHANGE_EVENT, callback)
})

AppDispatcher.register (action) ->
	switch action.actionType
		when ActionTypes.POST_LOADED_POSTS_DATA
			if typeof action.content is 'string'
				_postData = JSON.parse action.content
			else
				_postData = action.content
			PostStore.emitChange()
		when ActionTypes.POST_CREATE
			PostStore.emitChange()
		when ActionTypes.POST_CREATE_PREVIOUSLY
			_postData.unshift(action.post)
			PostStore.emitChange()
		when ActionTypes.POST_UPDATE_PREVIOUSLY
			_postData = _postData.map (post) ->
				if post.id is action.post.id then action.post else post
			PostStore.emitChange()
		when ActionTypes.POST_DESTROY_PREVIOUSLY
			_postData = _postData.filter (ele) -> ele.id != action.post.id
			PostStore.emitChange()
		when ActionTypes.POST_EDIT
			_editIdx = action.idx
			PostStore.emitChange()
		when ActionTypes.POST_MODAL_TRIGGER
			_isModalOpen = !_isModalOpen
			PostStore.emitChange()

module.exports = PostStore