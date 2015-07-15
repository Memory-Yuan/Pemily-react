Comment = require './CommentNode'
CommentFormBox = require './CommentFormBox'

CommentList = React.createClass

	displayName: 'CommentList'

	propTypes:
		commentsData: React.PropTypes.array
		post_id: React.PropTypes.number.isRequired
		editId: React.PropTypes.number

	render: ->
		commentNodes = @props.commentsData.map (comment, index) =>
			if @props.editId is comment.id
				<CommentFormBox key={index} comment={comment} post_id={@props.post_id} form_id="comment_edit_#{@props.post_id}_#{index}" />
			else
				<Comment key={index} idx={index} comment={comment} />

		<ul className='collection'>
			{ commentNodes }
			<CommentFormBox post_id={@props.post_id} form_id="comment_new_#{@props.post_id}" />
		</ul>

module.exports = CommentList
