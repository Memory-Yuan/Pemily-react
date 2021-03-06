AppDispatcher = require '../dispatcher/AppDispatcher'
AppConstants = require '../constants/AppConstants'
EventEmitter = require 'eventemitter3'
assign = require 'object-assign'
ActionTypes = AppConstants.ActionTypes

CHANGE_EVENT = 'change'

_postsData = []

_editCommentId = null

_postsDataOfPet = []

_currentPage = 1

_orderType = AppConstants.DefaultOrder

_getPostIdxByID = (post_id) ->
	post_idx = -1
	_postsData.some (post, index) ->
		if post.id == post_id
			post_idx = index
			true
	if post_idx is -1 then null else post_idx

PostStore = assign({}, EventEmitter.prototype, {
	getPosts: ->
		_postsData

	getEditCommentId: ->
		_editCommentId

	getPostsOfPet: ->
		_postsDataOfPet

	getCurrentPage: ->
		_currentPage

	getOrderType: ->
		_orderType

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
			_postsData = action.posts
			PostStore.emitChange()
		when ActionTypes.POST_CREATE_PREVIOUSLY
			_postsData.unshift(action.post)
			PostStore.emitChange()
		when ActionTypes.POST_UPDATE_PREVIOUSLY
			_postsData = _postsData.map (post) ->
				if post.id is action.post.id then action.post else post
			PostStore.emitChange()
		when ActionTypes.POST_DESTROY_PREVIOUSLY
			_postsData = _postsData.filter (ele) -> ele.id != action.post.id
			PostStore.emitChange()
		when ActionTypes.COMMENT_LOADED_COMMENTS_DATA
			comments = action.comments
			post_idx = _getPostIdxByID(action.post_id)
			_postsData[post_idx].comments = comments
			PostStore.emitChange()
		when ActionTypes.COMMENT_CREATE_PREVIOUSLY
			post_idx = _getPostIdxByID(action.post_id)
			_postsData[post_idx].comments = [] unless _postsData[post_idx].comments?
			_postsData[post_idx].comments.push(action.comment)
			PostStore.emitChange()
		when ActionTypes.COMMENT_UPDATE_PREVIOUSLY
			post_idx = _getPostIdxByID(action.comment.post_id)
			_postsData[post_idx].comments = _postsData[post_idx].comments.map (comment) ->
				if comment.id is action.comment.id then action.comment else comment
			PostStore.emitChange()
		when ActionTypes.COMMENT_DESTROY_PREVIOUSLY
			post_idx = _getPostIdxByID(action.comment.post_id)
			_postsData[post_idx].comments = _postsData[post_idx].comments.filter (comment) ->
				comment.id != action.comment.id
			PostStore.emitChange()
		when ActionTypes.COMMENT_EDIT
			_editCommentId = action.id
			PostStore.emitChange()
		when ActionTypes.COMMENT_EDIT_CANCEL
			_editCommentId = null
			PostStore.emitChange()
		when ActionTypes.POST_LOADED_POSTS_DATA_OF_PET
			_postsDataOfPet = action.posts
			PostStore.emitChange()
		when ActionTypes.POST_LOADED_NEXT_PAGE_POSTS_DATA
			_postsData = _postsData.concat(action.posts)
			_currentPage = action.page
			PostStore.emitChange()
		when ActionTypes.POST_SET_ORDER
			_orderType = action.order
			PostStore.emitChange()


module.exports = PostStore