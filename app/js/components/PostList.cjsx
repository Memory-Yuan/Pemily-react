React = require 'react'
Post = require './PostNode'

PostList = React.createClass
	render: ->
		warpStyle = 
			paddingLeft: '50px'

		postNodes = @props.postData.map (post, index) =>
			<Post key={index} post={post} idx={index} />
		<div style={warpStyle}>
			{ postNodes }
		</div>

module.exports = PostList