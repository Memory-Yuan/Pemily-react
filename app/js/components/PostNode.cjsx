React = require 'react'
PostAction = require '../actions/PostAction'
PetStore = require '../stores/PetStore'
RB = require 'react-bootstrap'
{ Panel, Button, DropdownButton, MenuItem } = RB
CommentBox = require './CommentBox'

PostNode = React.createClass

	handleDelete: (e) ->
		e.preventDefault()
		return unless confirm '真的要刪除嗎？'
		PostAction.destroyPost @props.post

	handleEdit: (e) ->
		e.preventDefault()
		PostAction.editPost(@props.idx)
		PostAction.triggerModal()

	render: ->
		panelStyle = 
			paddingLeft: '20px'

		asideStyle =
			position: 'absolute'
			top: '-1px'
			right: '-1px'

		imageStyle = 
			position: 'absolute'
			left: '-50px'
			top: '20px'
			width: '80px'
			height: '80px'

		iconEdit = <i className='glyphicon glyphicon-edit'></i>
		iconDel = <i className='glyphicon glyphicon-trash'></i>

		authOperate =
			if @props.post.pet and PetStore.isCorrectPet(@props.post.pet.id)
				<aside style={asideStyle}>
					<DropdownButton bsStyle={'default'} bsSize={'small'} pullRight>
						<MenuItem eventKey='1' onClick={@handleEdit}>{iconEdit} 編輯</MenuItem>
						<MenuItem eventKey='2' onClick={@handleDelete}>{iconDel} 刪除</MenuItem>
					</DropdownButton>
				</aside>
			else null

		<Panel className='pos-relative' style={panelStyle}>
			<article>
				<a href className='thumbnail' style={imageStyle}>
				</a>
				{authOperate}
				<h2><a href>{@props.post.pet.name}</a></h2>
				<h3>{@props.post.title}</h3>
				<p>{@props.post.content}</p>
				<CommentBox commentsData={@props.post.comments} post_id={@props.post.id} />
			</article>
		</Panel>

module.exports = PostNode