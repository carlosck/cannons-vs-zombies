
((root) ->

	root.zombie= (_hp,_body,_velocity,_cannon) -> 
		root.human.call(this,_hp,_body,_velocity)

		@cannon = _cannon
		
		@update= ->
			that = this
			if @is_walking
				@left-=@velocity 
					

			
			
				

		@start_walking= ->
			@left=800
			root.css(@body,{"left":@left+"px"})
			root.css(@body,{"top":(@cannon*100)+"px"})
			@is_walking= true
		
		
		return




	
	
	)(App)


