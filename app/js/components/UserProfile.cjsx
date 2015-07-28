Router = require 'react-router'
{ RouteHandler } = Router
Mixins = require '../mixins/Mixins'

# getAllStoreData = ->

UserProfile = React.createClass

	displayName: 'UserProfile'

	mixins: [Mixins.ApiResource]

	getDefaultProps: ->
		userData: null

	# getInitialState: -> getAllStoreData()

	# componentDidMount: ->
	# 	PostStore.addChangeListener(@_onChange)

	# componentWillUnmount: ->
	# 	PostStore.removeChangeListener(@_onChange)

	render: ->
		return <span/> unless @props.userData?
		
		<div className='row' style={styles.wrap}>
			<div className='col s3'>
				<div>
					<img className='z-depth-1' style={styles.avatar} src={@addApiUrl(@props.userData.avatar_url.medium)} alt={@props.userData.email}/>
				</div>
				<div className='collection'>
					<a href='#/user_profile' className='collection-item'>基本資料</a>
					<a href='#/user_profile/avatar' className='collection-item'>編輯大頭照</a>
					<a href='#!' className='collection-item'>Alvin</a>
					<a href='#!' className='collection-item'>Alvin</a>
					<a href='#!' className='collection-item'>Alvin</a>
				</div>
			</div>
			<div className='col s9'>
				<RouteHandler {...@props}/>
			</div>
		</div>
			

	# _onChange: ->
	# 	@setState getAllStoreData()

styles =
	wrap:
		marginTop: '20px'

	avatar:
		width: '100%'

module.exports = Radium UserProfile