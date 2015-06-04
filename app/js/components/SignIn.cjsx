React = require 'react'
SigninForm = require './SigninForm'

Signin = React.createClass
	render: ->
		wrapperStyle=
			margin: '0 auto'
			width: '50%'
		<div>
			<h1 className='center'>Signin</h1>
			<div style={wrapperStyle}>
				<SigninForm/>
				<a href='#/register'>註冊</a>
			</div>
		</div>

module.exports = Signin