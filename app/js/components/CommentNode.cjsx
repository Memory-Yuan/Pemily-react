PostAction = require '../actions/PostAction'
Mixins = require '../mixins/Mixins'

Comment = React.createClass

	displayName: 'CommentNode'

	mixins: [Mixins.ApiResource]

	propTypes:
		comment: React.PropTypes.object
		idx: React.PropTypes.number

	_handleDelete: () ->
		return unless confirm '真的要刪除嗎？'
		PostAction.destroyComment @props.comment

	_handleEdit: () ->
		PostAction.editComment(@props.comment.id)

	render: ->
		<li className='collection-item avatar'>
			<img src={@addApiUrl(@props.comment.pet.avatar_url.thumb)} alt={@props.comment.pet.name} className='circle' />
			<span className='title'>{@props.comment.pet.name}</span>
			<p>
				{@props.comment.content}
			</p>
			<aside className='secondary-content'>
				<a className='btn-floating waves-effect waves-light' onClick={@_handleEdit}><i className='material-icons'>mode_edit</i></a>
				<a className='btn-floating waves-effect waves-light red lighten-1' onClick={@_handleDelete}><i className='material-icons'>delete</i></a>
			</aside>
		</li>

module.exports = Comment
