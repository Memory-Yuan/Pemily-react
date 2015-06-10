keyMirror = require 'keymirror'

module.exports = 
	ActionTypes: keyMirror
		PET_LOADING_PETS_DATA: null,
		PET_LOADED_PETS_DATA: null,
		PET_NEW:null,
		PET_CREATE_PREVIOUSLY: null,
		PET_EDIT: null,
		PET_UPDATE_PREVIOUSLY: null,
		PET_DESTROY_PREVIOUSLY: null,
		PET_AS_PET: null,
		PET_LOADED_ONEPET_DATA: null,
		PET_MODAL_TRIGGER: null,
		FAILED: null,
		AUTH_STORE_API_TOKEN: null,
		AUTH_CLEAN: null,
		USER_LOADED_USER_DATA: null,
		USER_CLEAN_USER_DATA: null,
		POST_LOADED_POSTS_DATA: null,
		POST_CREATE: null,
		POST_CREATE_PREVIOUSLY: null,
		POST_UPDATE_PREVIOUSLY: null,
		POST_DESTROY_PREVIOUSLY: null,
		POST_MODAL_TRIGGER: null,
		POST_EDIT: null

	APIUrl: 'http://localhost:3000/api/v1/'
