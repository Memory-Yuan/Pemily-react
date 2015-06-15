React = require 'react'
PetStore = require '../stores/PetStore'
PostAction = require '../actions/PostAction'
RB = require 'react-bootstrap'
{ ListGroupItem, DropdownButton, MenuItem } = RB

Comment = React.createClass
	handleDelete: (e) ->
		e.preventDefault()
		return unless confirm '真的要刪除嗎？'
		PostAction.destroyComment @props.comment

	handleEdit: (e) ->
		e.preventDefault()
		PostAction.editComment(@props.idx)

	render: ->
		listItemStyle =
			paddingLeft: '20px'

		asideStyle =
			position: 'absolute'
			top: '-1px'
			right: '-1px'

		imageStyle = 
			position: 'absolute'
			left: '-25px'
			top: '10px'
			width: '40px'
			height: '40px'

		iconEdit = <i className='glyphicon glyphicon-edit'></i>
		iconDel = <i className='glyphicon glyphicon-trash'></i>

		authOperate = 
			if @props.comment.pet and PetStore.isCorrectPet(@props.comment.pet.id)
				<aside style={asideStyle}>
					<DropdownButton bsStyle={'default'} bsSize={'xsmall'} pullRight>
						<MenuItem eventKey='1' onClick={@handleEdit}>{iconEdit} 編輯</MenuItem>
						<MenuItem eventKey='2' onClick={@handleDelete}>{iconDel} 刪除</MenuItem>
					</DropdownButton>
				</aside>
			else null

		<ListGroupItem className='pos-relative' style={listItemStyle} header={<a href>{@props.comment.pet.name}</a>}>
			<a href className='thumbnail' style={imageStyle}>
			</a>
			{authOperate}
			{@props.comment.content}
		</ListGroupItem>

module.exports = Comment
