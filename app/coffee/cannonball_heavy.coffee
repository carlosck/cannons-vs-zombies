
((root) ->

	root.cannonball_heavy= (_body,_cannon) -> 
		root.projectile.call(this,150,_body,10,_cannon)
		
		@explode= ->
			@.body.parentNode.removeChild(@.body)		
		
		return
	)(App)


