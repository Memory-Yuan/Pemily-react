PetAction = require '../actions/PetAction'

PetProfileCoverEdit = React.createClass

	displayName: 'PetProfileCoverEdit'

	getInitialState: ->
		cover: null

	_handleChange: ->
		@setState cover: @refs.imageInput.getDOMNode().files[0] || null

	_renderImage: ->
		return null if !@state.cover
		anyWindow = window.URL || window.webkitURL
		objectUrl = anyWindow.createObjectURL(@state.cover)
		return <img className='responsive-img' src={objectUrl} />

	_submit: ->
		return null if !@state.cover
		PetAction.uploadCover(@props.pet.id, @state.cover)
		@_clean()

	_clean: ->
		@setState @getInitialState

	render: ->
		<div>
			<div className='file-field input-field'>
				<input className='file-path validate' style={styles.InputHide} type='text'/>
				<div className='btn'>
					<span>選擇檔案</span>
					<input type='file' ref='imageInput' onChange={@_handleChange} />
				</div>
			</div>
			<hr/>
			<div className='col s12'>
				{@_renderImage()}
			</div>
			<a className='waves-effect waves-light btn' onClick={@_clean} style={styles.btn}>清除</a>
			<a className='waves-effect waves-light btn' onClick={@_submit} style={styles.btn}>upload</a>
		</div>

styles =
	InputHide:
		width: '0px'
	btn:
		marginLeft: '16px'

module.exports = PetProfileCoverEdit