React = require 'react'
Post = require './PostNode'

PetIndex = React.createClass
	render: ->
		postNodes = @props.posts.map (post, index) =>
			<Post key={index} post={post} idx={index} />
		<div>
			<div>
				{ @props.pet.name }
			</div>
			<div className="col-xs-4">
				<h3>post</h3>
				<p>{postNodes}</p>
			</div>
			<div className="col-xs-4">album</div>
			<div className="col-xs-4">video</div>
		</div>

module.exports = PetIndex