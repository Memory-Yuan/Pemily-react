React = require 'react'


# getAllStoreData = ->

PetsAll = React.createClass
	# getInitialState: -> getAllStoreData()

	# componentDidMount: ->
	# 	PostStore.addChangeListener(@_onChange)

	# componentWillUnmount: ->
	# 	PostStore.removeChangeListener(@_onChange)

	render: ->
		console.log @props.params.id
		console.log @props.params.t_id
		<div>
			<h1>All pets</h1>
		</div>

	# _onChange: ->
	# 	@setState getAllStoreData()

module.exports = PetsAll