App= 
	init: ->
		@$stage= null 
		@$world= null
		@$yard= null
		@$game_over_alert= null
		@$continue_btn= null
		@$score_container= null
		
		@game= false
		@score= 0

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
		
		@div_count=0
		@projectile_count=0
		@projectiles_to_remove=new Array()
		@humans_to_remove=new Array()
		@enemy_thread = null
		@bind()
	bind: ->
		# #set herency to childs
		# App.zombie.prototype= new App.human
		# App.neighbor.prototype= new App.human
		# App.cannonball_fast.prototype= new App.projectile
		
		@$stage= @by_id("stage")
		@$world= @by_id("world")
		@$yard= @by_id("yard")
		@$game_over_alert= @by_id("game_over")
		@$continue_btn= @by_id("continue")
		@$score_container= @by_id("score")
		
		# balls
		@$ball_1= @by_id("ball_1")
		@$ball_2= @by_id("ball_2")
		@$ball_3= @by_id("ball_3")
		

		# cannons
		@$cannon_1= @by_id("cannon_1")
		@$cannon_2= @by_id("cannon_2")
		@$cannon_3= @by_id("cannon_3")
		@$cannon_4= @by_id("cannon_4")
		@$cannon_5= @by_id("cannon_5")

		
		
		@set_on(document,"keydown",App.key_down)
		@set_on(document,"keyup",App.key_up)

		@set_on(App.$continue_btn,"click",App.restart)
		
		@set_on(App.$ball_1,"dragstart",App.drag_start)
		@set_on(App.$ball_2,"dragstart",App.drag_start)
		@set_on(App.$ball_3,"dragstart",App.drag_start)
		

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
	
		
	drag_start:(event) ->
		event.dataTransfer.setData('ballid', event.target.id)
	drop:(event) ->
		ball_id=event.dataTransfer.getData("ballid")
		cannon_id=event.target
		
		App.shoot(cannon_id.id.replace("cannon_",""),ball_id)
		App.remove_class(cannon_id,"selected")
	drag_over:(event) ->
		event.preventDefault()
		event.stopPropagation()
		if !App.has_class(event.target,"selected")
			App.add_class(event.target,"selected")
		
	drag_leave:(event) ->
		event.preventDefault()
		App.remove_class(event.target,"selected")
	
	start: ->
		@score= 0
		@$yard.innerHTML= ""
		@game= true
		@humans= new Array()
		@projectiles = new Array()
		
		@div_count=0
		@projectile_count=0
		@projectiles_to_remove=new Array()
		@humans_to_remove=new Array()
		@enemy_thread = null
		App.make_an_enemy()
		@enemy_thread= setInterval(
			->
				App.make_an_enemy()
			,3000)
		
		App.main_loop()
	main_loop: ->
		App.projectiles_to_remove=new Array()
		App.humans_to_remove=new Array()
		for human , u in App.humans
			human.update()
			App.css(human.body,{"left":human.left+"px"})
			App.css(human.body,{"top":human.top+"px"})
			if human.left < 10
				@game_over()
				break


		for projectile , p in App.projectiles
			projectile.update()
			if projectile.left > 800
				projectile.destroy()
				App.projectiles_to_remove.push(p)
				
			else
				App.css(projectile.body,{"left":projectile.left+"px"})
				App.css(projectile.body,{"top":projectile.top+"px"})
		
		App.check_collitions()
		@$score_container.innerHTML= @score
		App.garbage_collection()
		

	
	check_collitions: ->
		for projectile, p in App.projectiles
			projectile_body= projectile.body
			projectile_rect= projectile_body.getBoundingClientRect()
			for human , h in App.humans
				human_body= human.body
				human_rect= human_body.getBoundingClientRect()

				if projectile_rect.left < human_rect.right & human_rect.left < projectile_rect.right & projectile_rect.top < human_rect.bottom & human_rect.top < projectile_rect.bottom 
					human.hit(projectile.damage)
					App.projectiles_to_remove.push(p)

					projectile.explode()
					if human.hp <= 0
						App.score+=human.points
						App.humans_to_remove.push(h)

					break	

					
	garbage_collection: ->
		i =0
		while i < App.projectiles_to_remove.length
			
			App.projectiles.splice(App.projectiles_to_remove[i], 1)
			i++

		j =0
		while j < App.humans_to_remove.length
			App.humans.splice(App.humans_to_remove[j], 1)
			j++
		if @game
			setTimeout(
				->
					App.main_loop()
				,150)
	make_an_enemy: ->
		div = document.createElement('div')
		# 0-9 = zombie
		# 10 = neighbor (bonus)
		enemy_type= Math.floor(Math.random()*21)
		if enemy_type <= 10
			div.className= "human zombie1"
			div.id= "enemy"+App.div_count
			div.innerHTML= "<div class='healt_bar'></div>"
			@$yard.appendChild(div)
			random_cannon= Math.floor(Math.random()*5)
			enemy=new App.zombie_fast(div,random_cannon)
		else
			if enemy_type > 10 and enemy_type <= 19
				div.className= "human zombie2"
				div.id= "enemy"+App.div_count
				div.innerHTML= "<div class='healt_bar'></div>"
				@$yard.appendChild(div)
				random_cannon= Math.floor(Math.random()*5)
				enemy=new App.zombie_heavy(div,random_cannon)
			else
				# if enemy_type is 20
				div.className= "human neighbor"
				div.id= "enemy"+App.div_count
				div.innerHTML= "<div class='healt_bar'></div>"
				@$yard.appendChild(div)
				enemy=new App.neighbor(100,div,10,300)


		App.div_count++
		enemy.start_walking()
		@humans.push(enemy)
	game_over: ->
		@game= false
		clearTimeout(@enemy_thread)
		@css(App.$game_over_alert,{opacity:"0",display:"block"})
		new @animate(App.$game_over_alert,{opacity:"1"},{duration:1000})
	shoot:(line,ball_type) ->
		div = document.createElement('div')
		div.className= "projectile"
		div.id= "projectile"+App.projectile_count
		div.innerHTML= "<div class='ball "+ball_type+"'></div>"
		@$yard.appendChild(div)
		switch ball_type
			when "ball_1"
				cannon=new App.cannonball_fast(div,line-1)
			when "ball_2"
				cannon=new App.cannonball_medium(div,line-1)
			when "ball_3"
				cannon=new App.cannonball_heavy(div,line-1)

		App.projectile_count++
		cannon.shoot()
		@projectiles.push(cannon)
	restart: (event)->
		App.prevent_default(event)
		new App.animate(App.$game_over_alert,{opacity:"0"},{duration:500,callback: ->
			App.css(App.$game_over_alert,{opacity:"0",display:"none"})
			App.start()
			})
		console.log "restart"


document.addEventListener 'DOMContentLoaded', ->
	App.init()