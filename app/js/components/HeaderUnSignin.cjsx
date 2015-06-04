React = require 'react'
RB = require 'react-bootstrap'
Nav = RB.Nav
NavItem = RB.NavItem

HeaderUnSignin = React.createClass
	render: ->
		<Nav navbar right>
			<NavItem eventKey={1} href='#/signin'>Signin</NavItem>
		</Nav>

module.exports = HeaderUnSignin
