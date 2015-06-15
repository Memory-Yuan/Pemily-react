React = require 'react'
CommentList = require './CommentList'
PostStore = require '../stores/PostStore'

getAllStoreData = ->
	editIdx: PostStore.getEditCommentIdx()

CommentBox = React.createClass
	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PostStore.addChangeListener(@_onChange)

	componentWillUnmount: ->
		PostStore.removeChangeListener(@_onChange)

	render: ->
		commentsData = if @props.commentsData then @props.commentsData else []
		<div>
			<CommentList
				commentsData={commentsData}
				post_id={@props.post_id} 
				editIdx={@state.editIdx} />
		</div>

	_onChange: ->
		@setState getAllStoreData()

module.exports = CommentBox