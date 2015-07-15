PetForm = require './PetForm'

PetModal = React.createClass

	displayName: 'PetModal'

	propTypes:
		pet: React.PropTypes.object
		m_id: React.PropTypes.string
		m_title: React.PropTypes.string

	getDefaultProps: ->
		pet: null
		m_id: 'defaulf_modal'
		m_title: 'Modal Header'

	trigger: ->
		@_resetData()
		$('#' + @props.m_id).openModal()

	dismiss: ->
		$('#' + @props.m_id).closeModal()

	_submit: ->
		@refs.petForm.submit(@dismiss)

	_resetData: ->
		@refs.petForm.reset()

	render: ->
		<div id={@props.m_id} className='modal'>
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