class Game

	constructor: ($game) ->
		# DOM Elements
		@$boardNode = $game.find('.board')
		@$levelNode = $game.find('.level span')
		@$shotCountNode = $game.find('.shotCount span')
		@$textNode = $game.find('.text')	
		# Configuration
		@speed = 80
		@level = 1
		@levelTime = 20000 # 20 Sec.
		@moveFactor = 5
		@pause = false
		@gameOver = false
		# Player, bullets and opponents
		@player = new Player($game,@$boardNode)
		@bullets = []
		@opponents = []

	start: ->
		@initKeyListener()
		@initMouseListener()	
		@increaseLevel()
		@run()
		
	initKeyListener: ->
		$(window).on 'keydown', (e) =>
			switch e.keyCode
				when Keys.ESC then e.preventDefault(); location.reload()
				when Keys.SPACE  
					return if @gameOver
					e.preventDefault()
					@pause = !@pause
					
					
	initMouseListener: ->
		$(window).on 'mousemove.movePlayer', (e) =>
			return if @gameOver or @pause 
			@player.move(e.pageX)

		$(window).bind 'click.shot', (e) =>
			return if @gameOver or @pause
			@bullets.push(@player.shot(e.pageX))
			e.preventDefault()
			e.stopPropagation()

	increaseLevel: ->
		setInterval =>
			return if @gameOver or @pause
			@level++;
			@$levelNode.html(@level)
		, @levelTime
		
	spawnOpponents: ->
		if Math.round(Math.random()*50) <= @level
			@opponents.push(new Opponent(@$boardNode))
		
	moveBackground: ->
		old = @$boardNode.css("background-position").split(" ")[1]
		old = Number(old.replace("px",""))
		old++
		css = "50% " + old + "px";
		@$boardNode.css("background-position",css)
	
	moveOpponents: ->
		for opponent, i in @opponents
			if opponent and opponent.$opponentNode and opponent.$opponentNode.length and (@$boardNode.offset().top + opponent.$opponentNode.offset().top) - opponent.$opponentNode.height() >= @$boardNode.height() + @$boardNode.offset().top 
				@gameOver = true
				opponent.destroy()
				@opponents.remove(i)
				
			else
				for i in [0..@moveFactor]
					opponent.move() if opponent
	
	moveBullets: ->
		for bullet, i in @bullets
			if bullet and bullet.$bulletNode and bullet.$bulletNode.length and bullet.$bulletNode.offset().top < @$boardNode.offset().top
				bullet.destroy()
				@bullets.remove(i)
				continue
			else
				for i in [0..@moveFactor]
					bullet.move() if bullet
	
	increaseShotCount: ->
		current = Number(@$shotCountNode.text())
		current++
		@$shotCountNode.html(current)
	
	collision: ->
		for opponent, i in @opponents
			if !opponent or opponent.dead or !opponent.$opponentNode or !opponent.$opponentNode.length
				@opponents.remove(i)
				continue
			for bullet, j in @bullets			
				if !bullet or bullet.dead
					@bullets.remove(j)
					continue
				if opponent.$opponentNode.collidesWith(bullet.$bulletNode).length
					opponent.destroy()
					bullet.destroy()
					@opponents.remove(i)
					@bullets.remove(j)
					@increaseShotCount()

	isGameOverOrPause: ->
		if @pause
			@$textNode.find(".pause").show()
		else 
			@$textNode.find(".pause").hide()
		if @gameOver
			@$textNode.find(".over").show("slow")
		return @pause || @gameOver;

	run: ->
		setInterval =>
			return if @isGameOverOrPause()
			return if @gameOver or @pause
			@spawnOpponents()
			@moveBackground()
			@moveOpponents()
			@moveBullets()
			@collision()
		, @speed
		
	
	
	
