React = require 'react'
RegisterForm = require './RegisterForm'
DocumentTitle = require 'react-document-title'
Mixins = require '../mixins/Mixins'

Register = React.createClass
	mixins: [Mixins.MooAuth]

	render: ->
		wrapperStyle=
			margin: '0 auto'
			width: '50%'
		<DocumentTitle title="Register | Pemily">
			<div>
				<h1 className='center'>Register</h1>
				<div style={wrapperStyle}>
					<RegisterForm/>
				</div>
			</div>
		</DocumentTitle>

module.exports = Register