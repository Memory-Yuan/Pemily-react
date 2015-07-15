PetStore = require '../stores/PetStore'
PostAction = require '../actions/PostAction'
CommentForm = require './CommentForm'

CommentFormBox = React.createClass

	displayName: 'CommentFormBox'

	propTypes:
		comment: React.PropTypes.object
		post_id: React.PropTypes.number.isRequired
		form_id: React.PropTypes.string

	_cancelEdit: ->
		PostAction.cancelEditComment()

	_submit: ->
		@refs.commentForm.submit()

	render: ->
		selectedPetData = PetStore.getSelectedPetData()

		if selectedPetData?
			petName = selectedPetData.name
			comment = if @props.comment then @props.comment else null

			styles =
				li:
					height: 'auto'
				btn_sm:
					height: '24px'
					lineHeight: '24px'
					padding: '0 0.5rem'
					marginLeft: '12px'
				operate:
					marginBottom: '0'

			cancelBtn =
				if @props.comment
					<a className='waves-effect waves-light btn white black-text' style={styles.btn_sm} onClick={@_cancelEdit}>取消</a>
				else
					null

			return(
				<li className='collection-item avatar' style={styles.li}>
					<img src='images/yuna.jpg' alt='' className='circle' />
					<span className='title'>{petName}</span>
					<div className='row valign-wrapper' style={styles.operate}>
						<div className='col s10'>
							<CommentForm ref="commentForm" post_id={@props.post_id} comment={comment} form_id={@props.form_id}/>
						</div>
						<div className='col s2 valign'>
							<a className='waves-effect waves-light btn' style={styles.btn_sm} onClick={@_submit}>確定</a>
							{cancelBtn}
						</div>
					</div>
				</li>
			)
		else
			return <span/>

module.exports = CommentFormBox
