React = require 'react'
RB = require 'react-bootstrap'
{ Navbar, Nav, NavItem, MenuItem, DropdownButton, CollapsibleNav, Input, Button } = RB
HeaderAuthArea = require './HeaderAuthArea'

Header = React.createClass
	render: ->
		navbarStyle =
			marginBottom: '0'

		searchBtn =
			<Button type='submit' bsStyle='default'>
				<i className='glyphicon glyphicon-search'></i>
			</Button>

		<Navbar style={navbarStyle} brand={<a href='#/'>PEMILY</a>} fluid staticTop inverse toggleNavKey={0}>
			<CollapsibleNav eventKey={0}>
				<Nav navbar>
					<form className='navbar-form navbar-left'>
						<Input type='text' buttonAfter={searchBtn} />
					</form>
				</Nav>
				<HeaderAuthArea {...@props}/>
			</CollapsibleNav>
		</Navbar>

module.exports = Header