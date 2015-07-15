FollowNode = require './FollowNode'

FollowList = React.createClass

	displayName: 'FollowList'

	propTypes:
		petsData: React.PropTypes.array

	render: ->
		listItems = @props.petsData.map (pet, index) =>
			<FollowNode key={index} pet={pet} />

		<ul className='collection'>{listItems}</ul>

module.exports = FollowList
