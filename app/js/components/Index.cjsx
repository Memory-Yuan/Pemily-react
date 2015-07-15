# getAllStoreData = ->

Index = React.createClass

	displayName: 'Index'

	# getInitialState: -> getAllStoreData()

	componentDidMount: ->
	# 	PostStore.addChangeListener(@_onChange)

	# componentWillUnmount: ->
	# 	PostStore.removeChangeListener(@_onChange)

	render: ->
		coverFont =
			fontSize: '64px'

		<div>
			<main className='cover orange'>
				<div className='section'>
					<p style={coverFont}>Pemily</p>
					<p>Pets are members of the family</p>
				</div>
			</main>
			<div className='container'>
				<div className="divider" />
				<section>hot pet</section>
				<div className="divider" />
				<section>hot post</section>
				<div className="divider" />
				<section>hot album</section>
				<div className="divider" />
				<section>hot video</section>
			</div>
		</div>

	# _onChange: ->
	# 	@setState getAllStoreData()

module.exports = Index