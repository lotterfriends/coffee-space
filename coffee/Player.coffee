class Player 
	
	constructor: (@$gameNode,@$boardNode) -> 
		@$playerNode = @$gameNode.find('.player:eq(0)')
	
	move: (left) ->
		return if left < @$boardNode.offset().left  
		return if left > @$boardNode.offset().left + @$boardNode.width() - @$playerNode.width()
		@$playerNode.css("left", left  + "px")

	shot: ->
		position = { 
		    left : @$playerNode.offset().left + (@$playerNode.width() / 2),
		    top : @$playerNode.offset().top
		}
		return new Bullet(@$boardNode, position)

