
# getAllStoreData = ->

PetsAll = React.createClass

	displayName: 'PetsAll'

	# getInitialState: -> getAllStoreData()

	# componentDidMount: ->
	# 	PostStore.addChangeListener(@_onChange)

	# componentWillUnmount: ->
	# 	PostStore.removeChangeListener(@_onChange)

	render: ->
		<div>
			<h1>All pets</h1>
		</div>

	# _onChange: ->
	# 	@setState getAllStoreData()

module.exports = PetsAll