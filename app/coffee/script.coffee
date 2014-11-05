App= 
	init: ->
		@$stage= null 
		@$world= null
		@game=null
		
		@$ball_1= null
		@$ball_2= null
		@$ball_3= null
		@$ball_4= null
		@$ball_5= null

		@$cannon_1= null
		@$cannon_2= null
		@$cannon_3= null
		@$cannon_4= null
		@$cannon_5= null
		
		@humans= new Array()
		@projectiles = new Array()
		@grounds = new Array()
		@div_count=0
		@projectile_count=0
		@enemy_thread = null
		@bind()
	bind: ->
		#set herency to zombie
		App.zombie.prototype= new App.human
		
		@$stage= @by_id("stage")
		@$world= @by_id("world")

		# balls
		@$ball_1= @by_id("ball_1")
		@$ball_2= @by_id("ball_2")
		@$ball_3= @by_id("ball_3")
		@$ball_4= @by_id("ball_4")
		@$ball_5= @by_id("ball_5")

		# balls
		@$cannon_1= @by_id("cannon_1")
		@$cannon_2= @by_id("cannon_2")
		@$cannon_3= @by_id("cannon_3")
		@$cannon_4= @by_id("cannon_4")
		@$cannon_5= @by_id("cannon_5")

		
		
		@set_on(document,"keydown",App.key_down)
		@set_on(document,"keyup",App.key_up)
		
		@set_on(App.$ball_1,"dragstart",App.drag_start)
		@set_on(App.$ball_2,"dragstart",App.drag_start)
		@set_on(App.$ball_3,"dragstart",App.drag_start)
		@set_on(App.$ball_4,"dragstart",App.drag_start)
		@set_on(App.$ball_5,"dragstart",App.drag_start)

		@set_on(App.$cannon_1,"drop",App.drop)
		@set_on(App.$cannon_2,"drop",App.drop)
		@set_on(App.$cannon_3,"drop",App.drop)
		@set_on(App.$cannon_4,"drop",App.drop)
		@set_on(App.$cannon_5,"drop",App.drop)

		@set_on(App.$cannon_1,"dragover",App.drag_over)
		@set_on(App.$cannon_2,"dragover",App.drag_over)
		@set_on(App.$cannon_3,"dragover",App.drag_over)
		@set_on(App.$cannon_4,"dragover",App.drag_over)
		@set_on(App.$cannon_5,"dragover",App.drag_over)

		@set_on(App.$cannon_1,"dragleave",App.drag_leave)
		@set_on(App.$cannon_2,"dragleave",App.drag_leave)
		@set_on(App.$cannon_3,"dragleave",App.drag_leave)
		@set_on(App.$cannon_4,"dragleave",App.drag_leave)
		@set_on(App.$cannon_5,"dragleave",App.drag_leave)

		@start()
	key_down: (event) ->
		console.log event.which
		switch 	event.which
			# jump
			when 32 
				App.hero.jump(true)
			# left
			when 37
				App.hero.set_walk_left(true)
			# right
			when 39
				App.hero.set_walk_right(true)
			# shoot
			when 83
				console.log "shoot"
				App.hero.shoot(true)
	key_up: (event) ->
		console.log event.which
		switch 	event.which
			# left
			when 37
				App.hero.set_walk_left(false)
			# right
			when 39
				App.hero.set_walk_right(false)
		
	drag_start:(event) ->
		
		event.dataTransfer.setData('ballid', event.target.id)
	drop:(event) ->
		ball_id=event.dataTransfer.getData("ballid")
		cannon_id=event.target
		console.log "ball->"+ball_id
		console.log "cannon->"+cannon_id.id
		App.shoot(cannon_id.id.replace("cannon_",""))
	drag_over:(event) ->
		event.preventDefault()
		event.stopPropagation()
		if !App.has_class(event.target,"selected")
			App.add_class(event.target,"selected")
		
		
	drag_leave:(event) ->
		event.preventDefault()
		App.remove_class(event.target,"selected")
	
	start: ->
		console.log "start"
		App.make_an_enemy()
		@enemy_thread= setInterval(
			->
				App.make_an_enemy()
			,1000)
		@game= setInterval(
			->
				App.main_loop()
			,100)
	main_loop: ->
		for human , u in App.humans
			human.update()
			App.css(human.body,{"left":human.left+"px"})
			App.css(human.body,{"top":human.top+"px"})

		for projectile , p in App.projectiles
			projectile.update()
			if projectile.left > 800
				# mark for delete
				App.projectiles.is_fired= false
			else
				App.css(projectile.body,{"left":projectile.left+"px"})
				App.css(projectile.body,{"top":projectile.top+"px"})

		App.check_collitions()

	check_collitions: ->
	# 	for projectil, i in App.projectiles
	# 		for human , u in App.humans
			
	# 			console.log human
	# 			console.log projectil
	make_an_enemy: ->
		random= Math.floor(Math.random()*5)
		
		div = document.createElement('div')
		div.className= "human"
		div.id= "enemy"+App.div_count
		div.innerHTML= "<div class='healt_bar'></div>"
		@$world.appendChild(div)
		zombie=new App.zombie(100,div,1,random)
		App.div_count++
		zombie.start_walking()
		# console.log zombie
		@humans.push(zombie)
	game_over: ->
		alert("game_over")
	shoot:(line) ->
		div = document.createElement('div')
		div.className= "projectile"
		div.id= "projectile"+App.projectile_count
		div.innerHTML= "<div class='ball'></div>"
		@$world.appendChild(div)
		cannon=new App.projectile(50,div,10,line-1)
		App.projectile_count++
		cannon.shoot()
		@projectiles.push(cannon)


document.addEventListener 'DOMContentLoaded', ->
	App.init()