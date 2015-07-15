Post = require './PostNode'

PostList = React.createClass

	displayName: 'PostList'

	render: ->
		postNodes = @props.postData.map (post, index) =>
			<Post key={index} post={post} idx={index} />
		<div>
			{ postNodes }
		</div>

module.exports = PostList