PostForm = require './PostForm'

PostModal = React.createClass

	displayName: 'PostModal'

	propTypes:
		post: React.PropTypes.object
		m_title: React.PropTypes.string

	getDefaultProps: ->
		post: null
		m_title: 'Modal Header'

	trigger: ->
		@_resetData()
		$(@refs.postModal.getDOMNode()).openModal()

	dismiss: ->
		$(@refs.postModal.getDOMNode()).closeModal()

	_submit: ->
		@refs.postForm.submit(@dismiss)

	_resetData: ->
		@refs.postForm.reset()

	render: ->

		<div ref='postModal' className='modal modal-fixed-footer'>
			<div className='modal-content'>
				<h4>{@props.m_title}</h4>
				<p><PostForm ref='postForm' post={@props.post} /></p>
			</div>
			<div className='modal-footer'>
				<a className='waves-effect waves-light btn' onClick={@_submit}>確定</a>
				<a onClick={@dismiss} className='waves-effect waves-green btn-flat'>關閉</a>
			</div>
		</div>

module.exports = PostModal