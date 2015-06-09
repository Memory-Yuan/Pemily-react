React = require 'react'
PetAction = require '../actions/PetAction'
RB = require 'react-bootstrap'
{Input, ButtonInput} = RB

PetForm = React.createClass
	getInitialState: ->
		if @props.pet
			pet: @props.pet
			type: 'PUT'
		else
			pet: {name: ''}
			type: 'POST'

	handleChange: ->
		pet = @state.pet
		pet.name = @refs.petName.getValue()
		@setState pet: pet

	handleSubmit: (e) ->
		e.preventDefault()
		return unless @state.pet.name

		if @state.type is 'POST'
			PetAction.createPet @state.pet
		else
			PetAction.updatePet @state.pet

	render: ->
		<form className='pet-form form-inline' onSubmit={ @handleSubmit }>
			<Input
				type='text'
				label='Name'
				placeholder='pet name'
				ref='petName'
				value={@state.pet.name}
				onChange={@handleChange}
				required />
			<ButtonInput type='submit' value='Post' bsStyle='primary' className='pull-right' wrapperClassName='col-xs-12'/>
		</form>

module.exports = PetForm