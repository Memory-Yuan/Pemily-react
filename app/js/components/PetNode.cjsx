PetAction = require '../actions/PetAction'
PetModal = require './PetModal'
Mixins = require '../mixins/Mixins'

Pet = React.createClass

	displayName: 'PetNode'

	mixins: [Mixins.ApiResource]

	propTypes:
		pet: React.PropTypes.object
		idx: React.PropTypes.number

	_handleDelete: ->
		return unless confirm '真的要刪除嗎？'
		PetAction.destroyPet @props.pet

	_handleEdit: ->
		@refs.petModal.trigger()

	_handleAsPet: ->
		PetAction.asPet(@props.pet.id)
		PetAction.getSelectedPet(@props.pet.id)

	render: ->
		<div className='col s6'>
			<div className='card'>
				<div className='card-image waves-effect waves-block waves-light'>
					<img className='activator' src={@addApiUrl(@props.pet.avatar_url.large)} />
				</div>
				<div className='card-content'>
					<span className='card-title activator grey-text text-darken-4'>{@props.pet.name}<i className='material-icons right'>more_vert</i></span>
					<p>
						<a className='waves-effect waves-teal btn-flat' onClick={@_handleAsPet}>選擇</a>
						<a className='waves-effect waves-teal btn-flat' onClick={@_handleEdit}>編輯</a>
						<a className='waves-effect waves-teal btn-flat' onClick={@_handleDelete}>刪除</a>
					</p>
					<p><a className='waves-effect waves-teal btn-flat' href="#/pets/#{@props.pet.id}">詳細</a></p>
				</div>
				<div className='card-reveal'>
					<span className='card-title grey-text text-darken-4'>{@props.pet.name}<i className='material-icons right'>close</i></span>
					<p>Here is some more information about this product that is only revealed once clicked on.</p>
				</div>

				<PetModal key={@props.idx} m_title='Edit pet' ref='petModal' pet={@props.pet} />
			</div>
		</div>

module.exports = Pet
