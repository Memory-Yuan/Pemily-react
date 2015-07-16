Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
PetAction = require '../actions/PetAction'

PetForm = React.createClass

	displayName: 'PetForm'

	mixins: [ValidationMixin]

	propTypes:
		pet: React.PropTypes.object

	validatorTypes:
		name: Joi.string().required().label('Name')

	getValidatorData: ->
		name: @state.pet.name

	getInitialState: ->
		pet: if @props.pet then @props.pet else {name: ''}

	submit: (callback) ->
		@validate (error, validationErrors) =>
			if error
				# @setState feedback: 'Form is invalid do not submit'
			else
				if @props.pet 
					PetAction.updatePet @state.pet
				else
					PetAction.createPet @state.pet
				callback() if callback
				@reset()

	reset: ->
		@setState @getInitialState()
		@clearValidations()

	_handleChange: ->
		pet = @state.pet
		pet.name = @refs.pet_name.getDOMNode().value.trim()
		@setState pet: pet

	_renderError: (field) ->
		return null if !@state.errors or $.isEmptyObject(@state.errors) or !@state.errors[field]
		errArr = @state.errors[field]
		if errArr.length is 0
			return null
		else
			return <span className='red-text text-lighten-1'>{errArr[0]}</span>

	render: ->
		<div className='input-field '>
			<input
				id='pet_name'
				ref='pet_name'
				type='text'
				value={@state.pet.name}
				onChange={@_handleChange} />
	        <label htmlFor='pet_name' className='active'>Name</label>
	        {@_renderError('name')}
		</div>

module.exports = PetForm