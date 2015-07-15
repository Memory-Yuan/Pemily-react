Pet = require './PetNode'

PetList = React.createClass

	displayName: 'PetList'

	propTypes:
		petsData: React.PropTypes.array

	render: ->
		petNodes = @props.petsData.map (pet, index) =>
			<Pet key={index} idx={index} pet={pet} />
		<div>{ petNodes }</div>

module.exports = PetList
