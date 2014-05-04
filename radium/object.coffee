class Object
	constructor: (@engine, @name) ->
		@sprite = null
		@x = 0
		@y = 0
		
	callEvent: (name, data = {}) =>
		switch name
			when "create" then @onCreate?(data)
			when "step" then @onStep?(data)
			when "draw"
				@drawSelf(data.surface ? "")
				@onDraw?(data)
		
	drawSelf: (surface) =>
		@drawSprite(surface)
		
	drawSprite: (surface = "") =>
		@sprite.draw(@x, @y, {}, surface) if @sprite? and (@draw_sprite ? "true")
	
	getBoundingBox: =>
		image_size = @sprite?.getSize()
		
		return {
			x1: @x
			x2: @x + image_size?.width
			y1: @y
			y2: @y + image_size?.height
		}
	
	checkPointCollision: (x, y) =>
		# TODO: Precision collision matching!
		bounding_box = @getBoundingBox()
			
		return x >= bounding_box?.x1 and x <= bounding_box?.x2 and y >= bounding_box?.y1 and y <= bounding_box?.y2
