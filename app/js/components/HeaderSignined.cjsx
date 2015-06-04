React = require 'react'
RB = require 'react-bootstrap'
AuthAction = require '../actions/AuthAction'
Nav = RB.Nav
NavItem = RB.NavItem
MenuItem = RB.MenuItem
DropdownButton = RB.DropdownButton

HeaderSignined = React.createClass
	
	handleSignout: ->
		AuthAction.signout()

	render: ->
		<Nav navbar right>
			<p className='navbar-text'>YES</p>
			<NavItem eventKey={1} href='#/pets'>My pets</NavItem>
			<DropdownButton eventKey={2} title={<i className='glyphicon glyphicon-cog'></i>}>
				<MenuItem eventKey='1'>Action</MenuItem>
				<MenuItem eventKey='2'>Another action</MenuItem>
				<MenuItem eventKey='3'>Something else here</MenuItem>
				<MenuItem divider />
				<MenuItem eventKey='4' onClick={ @handleSignout }>Signout</MenuItem>
			</DropdownButton>
		</Nav>

module.exports = HeaderSignined
