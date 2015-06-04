React = require 'react'
RegisterForm = require './RegisterForm'

Register = React.createClass
	render: ->
		wrapperStyle=
			margin: '0 auto'
			width: '50%'
		<div>
			<h1 className='center'>Register</h1>
			<div style={wrapperStyle}>
				<RegisterForm/>
			</div>
		</div>

module.exports = Register