React = require 'react'
PetAction = require '../actions/PetAction'
RB = require 'react-bootstrap'
{ Panel, Button } = RB

Pet = React.createClass
	handleDelete: ->
		return unless confirm '真的要刪除嗎？'
		PetAction.destroyPet @props.pet

	handleToggle: ->
		PetAction.editPet(@props.idx)
		PetAction.triggerModal()

	render: ->
		<Panel header={@props.pet.name}>
			<Button bsStyle='info' onClick={@handleToggle}>Edit</Button>
			<Button bsStyle='danger' onClick={@handleDelete}>刪除</Button>
		</Panel>

module.exports = Pet
