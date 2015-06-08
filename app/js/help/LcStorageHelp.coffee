LcStorageHelp = 
	GetDataBy: (key)->
		if localStorage[key]
			JSON.parse localStorage[key]
		else
			false

	StoreData: (key, data)->
		localStorage[key] = JSON.stringify data

	# DestroyDataBy: (key)->
	# 	delete localStorage[key]

module.exports = LcStorageHelp