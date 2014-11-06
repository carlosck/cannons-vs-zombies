
((root) ->

	root.zombie_heavy= (_body,_cannon) -> 
		root.human.call(this,350,_body,2,200) 

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


