class Explosion

	constructor: (@$boardNode, @position) ->
		@picture = "./img/explosion.gif"
		@$explosionNode = @create()
		@destroy()
		
	create: ->
		repeatStamp = "?" + new Date().valueOf()
		$explosionNode = $("<img class='explosion' src='"+ @picture + repeatStamp + "'>").appendTo(@$boardNode)
		$explosionNode.css("left", @position.left + "px")
		$explosionNode.css("top", @position.top + "px")
		$explosionNode.on 'dragstart', (e) =>
			e.preventDefault()
		return $explosionNode
		
	destroy: ->
		setTimeout =>
			@$explosionNode.hide('slow').remove()
		, 1000
