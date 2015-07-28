{ RouteHandler } = require 'react-router'
PetStore = require '../stores/PetStore'
PetAction = require '../actions/PetAction'
# PostStore = require '../stores/PostStore'
# PostAction = require '../actions/PostAction'
Mixins = require '../mixins/Mixins'

getAllStoreData = ->
	thisPetData: PetStore.getThisPetData()
	# postsOfPet: PostStore.getPostsOfPet()

PetProfile = React.createClass

	displayName: 'PetProfile'

	mixins: [Mixins.Authenticated, Mixins.ApiResource]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PetStore.addChangeListener(@_onChange)
		# PostStore.addChangeListener(@_onChange)
		PetAction.loadOnePet(@props.params.petID)
		# PostAction.loadPostsOfPet(@props.params.petID)
		# $(@refs.parallax.getDOMNode()).parallax()

	componentWillUnmount: ->
		PetStore.removeChangeListener(@_onChange)
		# PostStore.removeChangeListener(@_onChange)

	handleFollow: ->
		PetAction.followPet @state.thisPetData.id

	handleUnfollow: ->
		PetAction.unfollowPet @state.thisPetData.id, 'profile'

	_onChange: ->
		@setState getAllStoreData()

	_initialParallax: (component)->
		$(React.findDOMNode(component)).parallax()

	render: ->
		return <span/> unless @state.thisPetData

		followBtn =
			if !@props.userData or @state.thisPetData.user_id is @props.userData.id
				<span/>
			else if @state.thisPetData.is_followed
				<a className='waves-effect waves-light btn' onClick={@handleUnfollow}>已訂閱</a>
			else
				<a className='waves-effect btn white black-text' onClick={@handleFollow}>訂閱</a>

		<div>
			<div className='parallax-container'>
				<div className='parallax' ref={@_initialParallax}><img className='responsive-img' src={@addApiUrl(@state.thisPetData.cover_url.large)}/></div>
			</div>
			<div className='row' style={styles.wrap}>
				<div className='col s3'>
					<div className='z-depth-1' style={styles.avatarWrap}>
						<img style={styles.avatar} src={@addApiUrl(@state.thisPetData.avatar_url.medium)} alt={@state.thisPetData.name}/>
					</div>
					<div>
						{followBtn}
						訂閱人數: {@state.thisPetData.followers_count}
					</div>
					<div className='collection'>
						<a href="#/pets/#{@state.thisPetData.id}" className='collection-item'>基本資料</a>
						<a href="#/pets/#{@state.thisPetData.id}/avatar" className='collection-item'>編輯大頭照</a>
						<a href="#/pets/#{@state.thisPetData.id}/cover" className='collection-item'>編輯封面照</a>
						<a href='#!' className='collection-item'>Alvin</a>
						<a href='#!' className='collection-item'>Alvin</a>
					</div>
				</div>
				<div className='col s9'>
					<RouteHandler pet={@state.thisPetData}/>
				</div>
			</div>
		</div>

styles =
	wrap:
		marginTop: '16px'
	avatarWrap:
		width: '100%'
		border: '1px solid #e0e0e0'
		padding: '5px'
		marginBottom: '16px'
	avatar:
		height: 'auto'
		maxWidth: '100%'
		display: 'block'



module.exports = Radium PetProfile