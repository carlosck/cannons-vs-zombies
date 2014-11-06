
((root) ->

	root.cannonball_fast= (_body,_cannon) -> 
		root.projectile.call(this,50,_body,59,_cannon)
		
		@explode= ->
			@.body.parentNode.removeChild(@.body)		
		
		return
	)(App)


