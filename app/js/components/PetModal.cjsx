PetForm = require './PetForm'

PetModal = React.createClass

	displayName: 'PetModal'

	propTypes:
		pet: React.PropTypes.object
		m_title: React.PropTypes.string

	getDefaultProps: ->
		pet: null
		m_title: 'Modal Header'

	trigger: ->
		@_resetData()
		$(@refs.petModal.getDOMNode()).openModal()

	dismiss: ->
		$(@refs.petModal.getDOMNode()).closeModal()

	_submit: ->
		@refs.petForm.submit(@dismiss)

	_resetData: ->
		@refs.petForm.reset()

	render: ->
		<div ref='petModal' className='modal'>
			<div className='modal-content'>
				<h4>{@props.m_title}</h4>
				<p><PetForm ref='petForm' pet={@props.pet} /></p>
			</div>
			<div className='modal-footer'>
				<a className='waves-effect waves-light btn' onClick={@_submit}>確定</a>
				<a onClick={@dismiss} className='waves-effect waves-green btn-flat'>關閉</a>
			</div>
		</div>

module.exports = PetModal