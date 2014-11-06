
((root) ->

	root.neighbor= (_hp,_body,_velocity,_points) -> 
		root.human.call(this,_hp,_body,_velocity,_points)

		@_points = _points
		@xrand=0
		@yrand=0
		@update= ->
			that = this
			if @status=="alive"
				# if Math.abs(@left-@xrand) < @velocity
				# 	@xrand= @left

				# if Math.abs(@top-@yrand) < @velocity
				# 	@yrand= @top

				if Math.abs(@left-@xrand) < @velocity and Math.abs(@top-@yrand) < @velocity
					@new_path()
				else
					
					if @xrand < @left 
						@left-=@velocity
					else
						@left+=@velocity

					if @yrand < @top 
						@top-=@velocity
					else
						@top+=@velocity

				

					

			
			
				
		@new_path= ->
			@xrand= Math.floor(Math.random()*600)+100
			@yrand= Math.floor(Math.random()*400)
		@start_walking= ->
			@status="alive"
			@.new_path()

			@left= Math.floor(Math.random()*600)+100
			@top= Math.floor(Math.random()*500)

			root.find(@body,".healt_bar").innerHTML=this.hp
			
			root.css(@body,{"left":@left+"px"})
			root.css(@body,{"top":(@top)+"px"})
			@is_walking= true
			root.add_class(@body,"alive")
		
		
		return




	
	
	)(App)


