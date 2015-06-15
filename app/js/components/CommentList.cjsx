React = require 'react'
Comment = require './CommentNode'
RB = require 'react-bootstrap'
{ ListGroup, ListGroupItem } = RB
CommentForm = require './CommentForm'

CommentList = React.createClass
	render: ->
		commentNodes = @props.commentsData.map (comment, index) =>
			if @props.editIdx is index
				<ListGroupItem key={index}>
					<CommentForm comment={comment}/>
				</ListGroupItem>
			else
				<Comment key={index} idx={index} comment={comment} />
		<ListGroup>
			{ commentNodes }
			<ListGroupItem>
				<CommentForm post_id={@props.post_id}/>
			</ListGroupItem>
		</ListGroup>

module.exports = CommentList
