class Opponent
	
	constructor: (@$boardNode)  ->
		@dead = false
		@$opponentNode = @create()


	create: => 
		$opponentNode = $("<div class='opponent'>").appendTo(@$boardNode)
		$opponentNode.css('left', @findPosition($opponentNode) + 'px')
		return $opponentNode;
		
	findPosition: ($node) =>
		range = (Math.round((@$boardNode.width() - (@$boardNode.offset().left * 2)) / $node.width()) * $node.width()) * -1
		left = Math.round(Math.random() * range)
		left = @$boardNode.offset().left +  left
		if left > @$boardNode.offset().left + @$boardNode.width() - $node.width()
			return @findPosition($node)
		return left;
		
	destroy: =>
		if @$opponentNode.length
			new Explosion(@$boardNode, @$opponentNode.offset())
			@$opponentNode.remove()
			@dead = true
	
	move: =>
		return if @dead
		@$opponentNode.css "margin-top", "+=1px"		


