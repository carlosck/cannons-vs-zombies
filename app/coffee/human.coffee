
((root) ->

	root.human= (_hp,_body,_velocity,_points) -> 
		
		@hp = _hp
		@body= _body
		@left= null
		@top= null
		@velocity=_velocity
		@points= _points	
		@status="alive"		
		@hit= (damage)->
			@hp-=damage

			
			if @hp < 1
				root.find(@body,".healt_bar").innerHTML= "0"
				@status= "dying"
				root.remove_class(@.body,"alive")
				root.add_class(@.body,"dying")
				that= @
				setTimeout(
					->
						that.status= "die"
						that.die()
					,1000)
			else
				root.find(@body,".healt_bar").innerHTML=this.hp
		@die= ->
			if @.body.parentNode != null
				@.body.parentNode.removeChild(@.body)
		@update= ->




		return


	
	
	)(App)