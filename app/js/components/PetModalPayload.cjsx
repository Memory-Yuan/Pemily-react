React = require 'react'
PetAction = require '../actions/PetAction'
PetForm = require './PetForm'
RB = require 'react-bootstrap'
Modal = RB.Modal
Button = RB.Button

PetModalPayload = React.createClass
	handleToggle: ->
		PetAction.triggerModal()		

	render: ->
		return <span/> unless @props.isModalOpen

		title = if @props.pet then 'Edit pet' else 'New pet'

		<Modal {...@props} title={title} onRequestHide={@handleToggle}>
			<div className='modal-body'>
				<PetForm pet={@props.pet} />
			</div>
			<div className='modal-footer'>
				<Button onClick={@handleToggle}>Close</Button>
			</div>
		</Modal>

module.exports = PetModalPayload