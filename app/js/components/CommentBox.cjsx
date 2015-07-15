CommentList = require './CommentList'
PostStore = require '../stores/PostStore'

getAllStoreData = ->
	editId: PostStore.getEditCommentId()

CommentBox = React.createClass

	displayName: 'CommentBox'

	propTypes:
		commentsData: React.PropTypes.array
		post_id: React.PropTypes.number.isRequired

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PostStore.addChangeListener(@_onChange)

	componentWillUnmount: ->
		PostStore.removeChangeListener(@_onChange)

	_onChange: ->
		@setState getAllStoreData() if @isMounted()

	render: ->
		commentsData = if @props.commentsData then @props.commentsData else []
		<div>
			<CommentList
				commentsData={commentsData}
				post_id={@props.post_id}
				editId={@state.editId} />
		</div>

module.exports = CommentBox