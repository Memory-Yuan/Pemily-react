React = require 'react'
PetAction = require '../actions/PetAction'
RB = require 'react-bootstrap'
{ Panel, Button } = RB

FollowedPet = React.createClass
	
	handleUnfollow: ->
		PetAction.unfollowPet @props.pet.id, 'follow'

	render: ->
		<Panel header={@props.pet.name}>
			<Button onClick={@handleUnfollow}>取消訂閱</Button>
		</Panel>

module.exports = FollowedPet
