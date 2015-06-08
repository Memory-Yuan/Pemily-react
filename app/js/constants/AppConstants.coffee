keyMirror = require 'keymirror'

module.exports = 
	ActionTypes: keyMirror
		LOADING_PETSDATA: null,
		LOADED_PETSDATA: null,
		FAILED: null,
		NEW_PET:null,
		CREACT_PET_PRE: null,
		EDIT_PET: null,
		TRIGGER_MODAL: null,
		STORE_API_TOKEN: null,
		CLEAN_AUTH: null,
		LOADED_USERDATA: null,
		CLEAN_USERDATA: null,
		AS_PET: null,
		LOADED_ONEPETDATA: null

	APIUrl: 'http://localhost:3000/api/v1/'
