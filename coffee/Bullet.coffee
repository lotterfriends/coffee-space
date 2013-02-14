class Bullet

	constructor: (@$boardNode, @position) ->
		@dead = false
		@$bulletNode = @create()
		@speed = 5

	create: ->
		$bulletNode = $("<div class='bullet'>").appendTo(@$boardNode.closest(".game"));
		$bulletNode.css("left", @position.left)
		$bulletNode.css("top", @position.top)
		return $bulletNode

	destroy: -> 
		@$bulletNode.remove() if @$bulletNode.length
		@dead = true
		
	move: ->
		@$bulletNode.css("top", (@$bulletNode.offset().top - @speed)  + "px") if @$bulletNode.length
