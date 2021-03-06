keyMirror = require 'keymirror'

AppConstants = 
	ActionTypes: keyMirror
		HANDLE_FAILED: null,
		FAILED: null,
		PET_LOADING_MYPETS_DATA: null,
		PET_LOADED_MYPETS_DATA: null,
		PET_LOADED_SELECTED_PET_DATA: null,
		PET_LOADED_ONE_PET: null,
		PET_LOADED_FOLLOWED_PET_DATA: null,
		PET_CREATE_PREVIOUSLY: null,
		PET_UPDATE_PREVIOUSLY: null,
		PET_DESTROY_PREVIOUSLY: null,
		PET_AS_PET: null,
		PET_CLEAN_SELECTED_PET_DATA: null,
		AUTH_STORE_API_TOKEN: null,
		AUTH_CLEAN: null,
		USER_REGISTER_SUCCESS: null,
		USER_LOADED_USER_DATA: null,
		USER_CLEAN_USER_DATA: null,
		POST_LOADED_POSTS_DATA: null,
		POST_LOADED_POSTS_DATA_OF_PET: null,
		POST_LOADED_NEXT_PAGE_POSTS_DATA: null,
		POST_CREATE_PREVIOUSLY: null,
		POST_UPDATE_PREVIOUSLY: null,
		POST_DESTROY_PREVIOUSLY: null,
		COMMENT_LOADED_COMMENTS_DATA: null,
		COMMENT_CREATE_PREVIOUSLY: null,
		COMMENT_UPDATE_PREVIOUSLY: null,
		COMMENT_DESTROY_PREVIOUSLY: null,
		COMMENT_EDIT: null,
		COMMENT_EDIT_CANCEL: null

	APIBase: 'http://localhost:3000'
	APIUrl: 'http://localhost:3000/api/v1'
	DefaultOrder: 'updated_at'
	DefaultPerPage: 10
	ErrorMsgs:
		Unauthorized: '帳號密碼錯誤。'
		RegisterFailed: '註冊失敗。'

module.exports = AppConstants
