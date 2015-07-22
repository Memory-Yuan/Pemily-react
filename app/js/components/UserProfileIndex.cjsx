UserProfileIndex = React.createClass

	displayName: 'UserProfileIndex'

	render: ->
		return <span/> unless @props.userData?

		<div>
			{@props.userData.email}
		</div>

module.exports = Radium UserProfileIndex