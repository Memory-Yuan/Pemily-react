React = require 'react'
PetAction = require '../actions/PetAction'
RB = require 'react-bootstrap'
{ Panel, Button } = RB

Pet = React.createClass
	handleDelete: ->
		return unless confirm '真的要刪除嗎？'
		PetAction.destroyPet @props.pet

	handleEdit: ->
		PetAction.editPet(@props.idx)
		PetAction.triggerModal()

	handleAsPet: ->
		PetAction.asPet(@props.pet.id)
		PetAction.getSelectedPet(@props.pet.id)

	render: ->
		<Panel header={@props.pet.name}>
			<Button bsStyle='primary' onClick={@handleAsPet}>選擇</Button>
			<Button bsStyle='info' onClick={@handleEdit}>編輯</Button>
			<Button bsStyle='danger' onClick={@handleDelete}>刪除</Button>
		</Panel>

module.exports = Pet
