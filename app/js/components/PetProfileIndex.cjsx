# Post = require './PostNode'

PetProfileIndex = React.createClass

	displayName: 'PetIndex'

	render: ->
		# postNodes = @props.posts.map (post, index) =>
		# 	<Post key={index} post={post} idx={index} />
		<div>
			<div>
				{ @props.pet.name }
			</div>
		</div>

module.exports = PetProfileIndex