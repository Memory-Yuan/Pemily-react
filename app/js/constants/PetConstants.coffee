keyMirror = require 'keymirror'

module.exports = 
	ActionTypes: keyMirror
		LOADING_PETSDATA: null,
		LOADED_PETSDATA: null,
		FAILED: null,
		NEW_PET:null,
		CREACT_PET_PRE: null,
		EDIT_PET: null,
		TRIGGER_MODAL: null

	APIUrl: 'http://localhost:3000/api/v1/pets'
