React = require 'react'


# getAllStoreData = ->

Index = React.createClass
	# getInitialState: -> getAllStoreData()

	# componentDidMount: ->
	# 	PostStore.addChangeListener(@_onChange)

	# componentWillUnmount: ->
	# 	PostStore.removeChangeListener(@_onChange)

	render: ->
		coverFont = 
			fontSize: '64px'

		<div>
			<main className='cover'>
				<p style={coverFont}>Pemily</p>
				<p>Pets are members of the family</p>
			</main>
			<div className='container'>
				<div>hot post</div>
				<hr/>
				<div>hot album</div>
				<hr/>
				<div>hot video</div>
			</div>
		</div>

	# _onChange: ->
	# 	@setState getAllStoreData()

module.exports = Index