
((root) ->

	root.projectile= (_damage,_body,_velocity,_cannon) -> 
		@damage= _damage
		@body= _body
		@velocity = _velocity
		@cannon= _cannon
		@left= null
		@top= null
		@update= ->
			that = this
			if @is_fired
				@left+=@velocity 


		@shoot= ->
			@left=0
			root.css(@body,{"left":@left+"px"})
			root.css(@body,{"top":(@cannon*100)+"px"})
			@is_fired= true
		@explode= ->

			@.body.parentNode.removeChild(@.body)
		@destroy= ->
			if @.body.parentNode != null 
				@.body.parentNode.removeChild(@.body)
		
		
		return




	
	
	)(App)


