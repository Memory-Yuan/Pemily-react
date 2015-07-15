PostAction = require '../actions/PostAction'
PetStore = require '../stores/PetStore'
PostModal = require './PostModal'
CommentBox = require './CommentBox'

PostNode = React.createClass

	displayName: 'PostNode'

	propTypes:
		post: React.PropTypes.object
		idx: React.PropTypes.number

	_handleDelete: () ->
		return unless confirm '真的要刪除嗎？'
		PostAction.destroyPost @props.post

	_handleEdit: () ->
		@refs.postModal.trigger()

	_getOperate: ->
		if @props.post.pet and PetStore.isCorrectPet(@props.post.pet.id)
			return(
				<aside>
					<a className="btn-floating btn waves-effect waves-light" onClick={@_handleEdit}><i className="material-icons">mode_edit</i></a>
					<a className="btn-floating btn waves-effect waves-light red lighten-1" onClick={@_handleDelete}><i className="material-icons">delete</i></a>
				</aside>
			)
		else
			return <span/>

	render: ->
		styles =
			node:
				marginBottom: '24px'
		<div>
			<div className='z-depth-1 row' style={styles.node}>
				<div className='col s1'><i className='material-icons medium'>photo</i></div>
				<div className='col s11'><h4>{@props.post.pet.name}</h4></div>
				<div className='col s11 offset-s1'>
					<article>
						{@_getOperate()}
						<h5>{@props.post.title}</h5>
						<p>{@props.post.content}</p>
						<p><CommentBox commentsData={@props.post.comments} post_id={@props.post.id}/></p>
					</article>
				</div>
			</div>
			<PostModal key={@props.idx} m_id="post_edit_modal_#{@props.idx}" m_title='Edit post' ref='postModal' post={@props.post} />
		</div>

module.exports = PostNode