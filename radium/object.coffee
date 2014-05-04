# NOTE: All class methods are loosely bound (ie. -> instead of =>). This is to
#       make sure that @properties refer to instances of Objects, rather than
#       the defaults set in the Object class.

class Object
	constructor: (@engine, @name) ->
		@sprite = null
		@instances = []
		@x = 0
		@y = 0
		
	callEvent: (name, data = {}) ->
		event_map =
			mouseover: @onMouseOver
			mouseout: @onMouseOut
			create: @onCreate
			step: @onStep
		
		switch name
			when "draw"
				@drawSelf(data.surface ? "")
				@onDraw?(data)
			else event_map[name]?.bind(this)(data)
		
	drawSelf: (surface) ->
		@drawSprite(surface)
		
	drawSprite: (surface = "") ->
		@sprite.draw(@x, @y, {}, surface) if @sprite? and (@draw_sprite ? "true")
	
	getBoundingBox: ->
		image_size = @sprite?.getSize()
		
		return {
			x1: @x
			x2: @x + image_size?.width
			y1: @y
			y2: @y + image_size?.height
		}
	
	getInstances: ->
		return @instances
	
	checkPointCollision: (x, y) ->
		# TODO: Precision collision matching!
		bounding_box = @getBoundingBox()
		
		return x >= bounding_box?.x1 and x <= bounding_box?.x2 and y >= bounding_box?.y1 and y <= bounding_box?.y2
