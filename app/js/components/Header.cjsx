AuthAction = require '../actions/AuthAction'
Router = require 'react-router'

Header = React.createClass

	displayName: 'Header'

	mixins: [Router.Navigation, Router.State]

	_signout: ->
		AuthAction.signout()

	_getNavLinks: ->
		authLinks = [
			<li key='0'><a href='#/mypets'>My pets</a></li>
			<li key='1'><a href='#/myfollow'>My followed pets</a></li>
			<li key='2'><a href='#/channel'>My Channel</a></li>
			<li key='3' className='divider'></li>
			<li key='4'><a href='#' onClick={@_signout}>Sign out</a></li>
		]

		unAuthLink = [
			<li key='5'><a href='#/signin'>Sign in</a></li>
		]

		return if @props.isAuthenticated then authLinks else unAuthLink

	_getAuthData: ->
		email = if @props.userData? then @props.userData.email else 'no data'
		if @props.selectedPetData?
			petName = @props.selectedPetData.name
			petUrl = '#/pets/#{@props.selectedPetData.id}'
		else
			petName = 'no data'
			petUrl = '#'

		return [
			<li key='1'><a href='#'>{email}</a></li>
			<li key='2'><a href={petUrl}>{petName}</a></li>
		]

	render: ->
		styles = 
			authed:
				display: if @props.isAuthenticated then 'block' else 'none'

			unauth:
				display: if @props.isAuthenticated then 'none' else 'block'

		<div>
			<nav className='orange'>
				<div className='nav-wrapper'>
					<a href='#/' className='brand-logo'>PEMILY</a>
					<a href='#' data-activates='mobile-side-nav' className='button-collapse'><i className='material-icons'>menu</i></a>
					<ul key='0' className='right hide-on-med-and-down' style={styles.authed}>
						{@_getAuthData()}
						<li key='0'><a className='dropdown-button' href='#' data-activates='navbar-dropdown'>Dropdown<i className='material-icons right'>arrow_drop_down</i></a></li>
					</ul>
					<ul key='1' className='right hide-on-med-and-down' style={styles.unauth}>
						<li><a href='#/signin'>Sign in</a></li>
					</ul>
				</div>
			</nav>

			<ul key='0' id='navbar-dropdown' className='dropdown-content'>
				<li key='0'><a href='#/mypets'>My pets</a></li>
				<li key='1'><a href='#/myfollow'>My followed pets</a></li>
				<li key='2'><a href='#/channel'>My Channel</a></li>
				<li key='3' className='divider'></li>
				<li key='4'><a href='#' onClick={@_signout}>Sign out</a></li>
			</ul>

			<ul key='1' id='mobile-side-nav' className='side-nav'>
				{@_getNavLinks()}
			</ul>
		</div>

module.exports = Header