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

	handleAsPet: ->
		PetAction.asPet(@props.pet.id)
		PetAction.getOnePet(@props.pet.id)

	render: ->
		<Panel header={@props.pet.name}>
			<Button bsStyle='primary' onClick={@handleAsPet}>選擇</Button>
			<Button bsStyle='info' onClick={@handleToggle}>Edit</Button>
			<Button bsStyle='danger' onClick={@handleDelete}>刪除</Button>
		</Panel>

module.exports = Pet
