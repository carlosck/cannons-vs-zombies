
((root) ->

	root.zombie_fast= (_body,_cannon) -> 
		root.human.call(this,75,_body,10,100) 

		@cannon = _cannon
		
		@update= ->
			that = this
			if @status="alive" or @status="dying"
				@left-=@velocity 
					

		@start_walking= ->
			root.find(@body,".healt_bar").innerHTML=this.hp
			@left=700
			root.css(@body,{"left":@left+"px"})
			root.css(@body,{"top":(@cannon*100)+"px"})
			root.add_class(@body,"alive")
			@is_walking= true
		
		
		return




	
	
	)(App)


