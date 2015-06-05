React = require 'react'
RB = require 'react-bootstrap'
{ Navbar, Nav, NavItem, MenuItem, DropdownButton, CollapsibleNav } = RB
HeaderAuthArea = require './HeaderAuthArea'

Header = React.createClass
	render: ->				
		<Navbar brand={<a href='/'>PEMILY</a>} fluid staticTop toggleNavKey={0}>
			<CollapsibleNav eventKey={0}>
				<Nav navbar>
					<NavItem eventKey={1} href='#'>Link</NavItem>
					<NavItem eventKey={2} href='#'>Link</NavItem>
					<DropdownButton eventKey={3} title='Dropdown'>
						<MenuItem eventKey='1'>Action</MenuItem>
						<MenuItem eventKey='2'>Another action</MenuItem>
						<MenuItem eventKey='3'>Something else here</MenuItem>
						<MenuItem divider />
						<MenuItem eventKey='4'>Separated link</MenuItem>
					</DropdownButton>
				</Nav>
				<HeaderAuthArea/>
			</CollapsibleNav>
		</Navbar>

module.exports = Header