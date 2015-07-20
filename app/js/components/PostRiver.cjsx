PostAction = require '../actions/PostAction'
PostStore = require '../stores/PostStore'
PostList = require './PostList'
PostForm = require './PostForm'
Mixins = require '../mixins/Mixins'
AppConstants = require '../constants/AppConstants'

getAllStoreData = ->
	postData: PostStore.getPosts()
	currentPage: PostStore.getCurrentPage()
	orderType: PostStore.getOrderType()

PostRiver = React.createClass

	displayName: 'PostRiver'

	mixins: [Mixins.Authenticated]

	getInitialState: -> getAllStoreData()

	componentDidMount: ->
		PostStore.addChangeListener(@_onChange)
		PostAction.loadPostsFromServer()
		$(@refs.orderType.getDOMNode()).material_select()

	componentWillUnmount: ->
		PostStore.removeChangeListener(@_onChange)

	_handleLoadNextPage: ->
		PostAction.loadNextPage(@state.currentPage + 1, @state.orderType)

	_onOrderChange: ->
		order = @refs.orderType.getDOMNode().value
		return if order is 'hot'
		@setState orderType: order
		PostAction.loadPostsFromServer(order, @state.currentPage * AppConstants.DefaultPerPage)
		PostAction.setOrderType(order)

	_submit: ->
		@refs.postForm.submit()

	_onChange: ->
		@setState getAllStoreData()

	render: ->
		styles =
			postForm:
				padding: '16px'
				margin: '20px 0'

			input:
				marginBottom: '16px'

		<div className='container'>
			<div>
				<label>Order by</label>
				<select ref='orderType' className='browser-default' value={@state.orderType} onChange={@_onOrderChange}>
					<option key='0' value='created_at'>最新</option>
					<option key='1' value='updated_at'>更新</option>
					<option key='2' value='hot'>熱門</option>
				</select>
			</div>
			
			<div className='z-depth-1' style={styles.postForm}>
				<div style={styles.input}>
					<PostForm ref='postForm' />
				</div>
				<div className='right-align'>
					<a className='waves-effect waves-light btn' onClick={@_submit}>Submit</a>
				</div>
			</div>
			<PostList postData={@state.postData} />

			<a className="waves-effect waves-light btn" onClick={@_handleLoadNextPage}>next</a>
			<span>page: {@state.currentPage}</span>
		</div>

module.exports = PostRiver