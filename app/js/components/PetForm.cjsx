Joi = require 'joi'
ValidationMixin = require 'react-validation-mixin'
PetAction = require '../actions/PetAction'

PetForm = React.createClass

	displayName: 'PetForm'

	mixins: [ValidationMixin]

	validatorTypes:
		name: Joi.string().required().label('Name')

	propTypes:
		pet: React.PropTypes.object

	getInitialState: ->
		name: if @props.pet then @props.pet.name else ''

	submit: (callback) ->
		@validate (error, validationErrors) =>
			if error
				# @setState feedback: 'Form is invalid do not submit'
			else
				if @props.pet 
					PetAction.updatePet @_getPet()
				else
					PetAction.createPet @_getPet()
				callback() if callback
				@reset()

	reset: ->
		@setState @getInitialState()
		@clearValidations()

	_getPet: ->
		name: @state.name
		id: if @props.pet then @props.pet.id else null

	_handleChange: ->
		@setState name: @refs.name.getDOMNode().value.trim()

	_renderError: (field) ->
		return null if !@state.errors or $.isEmptyObject(@state.errors)
		errArr = @state.errors[field]
		if errArr.length is 0
			return null
		else
			return <span className='red-text text-lighten-1'>{errArr[0]}</span>

	render: ->
		<div className='input-field '>
			<input
				id='pet_name'
				ref='name'
				type='text'
				value={@state.name}
				onChange={@_handleChange} />
	        <label htmlFor='pet_name' className='active'>Name</label>
	        {@_renderError('name')}
		</div>

module.exports = PetForm