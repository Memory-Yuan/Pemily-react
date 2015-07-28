AuthAction = require '../actions/AuthAction'
Router = require 'react-router'
Mixins = require '../mixins/Mixins'

Header = React.createClass

	displayName: 'Header'

	mixins: [Router.Navigation, Router.State, Mixins.ApiResource]

	_signout: ->
		AuthAction.signout()

	_getNavSideContent: ->
		authLinks = [
			<li key='0'><a href='#/mypets'>My pets</a></li>
			<li key='1'><a href='#/myfollow'>My followed pets</a></li>
			<li key='2'><a href='#/channel'>My Channel</a></li>
			<li key='3' className='divider'></li>
			<li key='4'><a href='#/user_profile'>Profile</a></li>
			<li key='5'><a href='#' onClick={@_signout}>Sign out</a></li>
		]

		unAuthLink = [
			<li key='5'><a href='#/signin'>Sign in</a></li>
		]

		return if @props.isAuthenticated then authLinks else unAuthLink

	_renderSelPet: ->
		if @props.selectedPetData?
			<li key='1' style={styles.height100Pa}><a style={styles.height100Pa} href="#/pets/#{@props.selectedPetData.id}">
				<img style={styles.petAvatar} src={@addApiUrl(@props.selectedPetData.avatar_url.thumb)} />
				{@props.selectedPetData.name}
			</a></li>
		else
			<li key='1'><a href='#/mypets'>請選擇寵物</a></li>


	_getAuthData: ->
		email = if @props.userData? then @props.userData.email else 'no data'
		if @props.selectedPetData?
			petName = @props.selectedPetData.name
			petUrl = "#/pets/#{@props.selectedPetData.id}"
		else
			petName = 'no data'
			petUrl = '#'

		return [
			<li key='1'><a href='#'>{email}</a></li>
			<li key='2'><a href={petUrl}>{petName}</a></li>
		]

	_initialNavSide: (component)->
		$(React.findDOMNode(component)).sideNav()

	render: ->
		<div>
			<nav className='orange'>
				<div className='nav-wrapper'>
					<a href='#/' className='brand-logo'>PEMILY</a>
					<a href='#' ref={@_initialNavSide} data-activates='mobile-side-nav' className='button-collapse'><i className='material-icons'>menu</i></a>
					<ul key='0' className='right hide-on-med-and-down' style={[styles.isShow(@props.isAuthenticated), styles.height100Pa]}>
						{@_renderSelPet()}
						<li key='0'><a className='dropdown-button' data-beloworigin='true' data-constrainwidth='false' href='#' data-activates='navbar-dropdown'>Dropdown<i className='material-icons right'>arrow_drop_down</i></a></li>
					</ul>
					<ul key='1' className='right hide-on-med-and-down' style={styles.isHide(@props.isAuthenticated)}>
						<li><a href='#/signin'>Sign in</a></li>
					</ul>
				</div>
			</nav>

			<ul key='0' id='navbar-dropdown' className='dropdown-content'>
				<li key='0'><a href='#/mypets'>My pets</a></li>
				<li key='1'><a href='#/myfollow'>My followed pets</a></li>
				<li key='2'><a href='#/channel'>My Channel</a></li>
				<li key='3' className='divider'></li>
				<li key='4'><a href='#/user_profile'>Profile</a></li>
				<li key='5'><a href='#' onClick={@_signout}>Sign out</a></li>
			</ul>

			<ul key='1' id='mobile-side-nav' className='side-nav'>
				{@_getNavSideContent()}
			</ul>
		</div>

styles =
	isShow: (s) ->
		display: if s then 'block' else 'none'
	isHide: (h) ->
		display: if h then 'none' else 'block'
	petAvatar:
		maxWidth: '50px'
		maxHeight: '50px'
		verticalAlign: 'middle';
		marginRight: '12px'
	"height100Pa":
		height: '100%'

module.exports = Radium Header