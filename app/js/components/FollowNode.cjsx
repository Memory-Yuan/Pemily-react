PetAction = require '../actions/PetAction'

FollowNode = React.createClass

	displayName: 'FollowNode'

	propTypes:
		petsData: React.PropTypes.object

	_handleUnfollow: (e) ->
		e.preventDefault()
		PetAction.unfollowPet @props.pet.id, 'follow'

	render: ->
		<li className='collection-item avatar'>
			<img src='images/yuna.jpg' alt='' className='circle' />
			<span className='title'>{@props.pet.name}</span>
			<p>
				First Line <br />
				Second Line
			</p>
			<a href className='secondary-content' onClick={@_handleUnfollow}><i className='material-icons'>grade</i></a>
		</li>

module.exports = FollowNode
