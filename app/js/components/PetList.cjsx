React = require 'react'
Pet = require './PetNode'

PetList = React.createClass
	render: ->
		petNodes = @props.petsData.map (pet, index) =>
			<Pet key={index} idx={index} pet={pet} />
		<div>{ petNodes }</div>

module.exports = PetList
