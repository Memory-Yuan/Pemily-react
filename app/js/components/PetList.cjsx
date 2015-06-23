React = require 'react'
Pet = require './PetNode'
FollowPet = require './FollowedPetNode'

PetList = React.createClass
	render: ->
		petNodes = @props.petsData.map (pet, index) =>
			if @props.nodeType and @props.nodeType is 'follow'
				<FollowPet key={index} pet={pet} />
			else
				<Pet key={index} idx={index} pet={pet} />
		<div>{ petNodes }</div>

module.exports = PetList
