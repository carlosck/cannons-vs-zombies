
((root) ->

	root.cannonball_medium= (_body,_cannon) -> 
		root.projectile.call(this,75,_body,30,_cannon)
		
		@explode= ->
			@.body.parentNode.removeChild(@.body)		
		
		return
	)(App)


