React = require 'react'
RB = require 'react-bootstrap'
{ Nav, NavItem } = RB

HeaderUnSignin = React.createClass
	render: ->
		<Nav navbar right>
			<NavItem eventKey={1} href='#/signin'>Signin</NavItem>
		</Nav>

module.exports = HeaderUnSignin
