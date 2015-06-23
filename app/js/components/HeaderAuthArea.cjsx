React = require 'react'
AuthAction = require '../actions/AuthAction'
RB = require 'react-bootstrap'
{ Nav, NavItem, MenuItem, DropdownButton } = RB

HeaderAuthArea = React.createClass

	handleSignout: (e) ->
		e.preventDefault()
		AuthAction.signout()

	render: ->
		unless @props.isAuthenticated
			return (
				<Nav key='1' navbar right>
					<NavItem eventKey={1} href='#/signin'>Signin</NavItem>
				</Nav>
			)

		email = if @props.userData then @props.userData.email else 'no data'
		if @props.selectedPetData
			petName = @props.selectedPetData.name
			petUrl = "#/mypets/#{@props.selectedPetData.id}"
		else
			petName = 'no data'
			petUrl = '#'

		<Nav key='2' navbar right>
			<NavItem eventKey={1} href='#'>{email}</NavItem>
			<NavItem eventKey={2} href={petUrl}>{petName}</NavItem>
			<DropdownButton eventKey={3} title={<i className='glyphicon glyphicon-cog'></i>}>
				<MenuItem eventKey='1' href='#/mypets'>My Pets</MenuItem>
				<MenuItem eventKey='2' href='#/channel'>My Channel</MenuItem>
				<MenuItem eventKey='3' href='#/myfollow'>My Subscription</MenuItem>
				<MenuItem divider />
				<MenuItem eventKey='4' onClick={ @handleSignout }>Signout</MenuItem>
			</DropdownButton>
		</Nav>

module.exports = HeaderAuthArea
