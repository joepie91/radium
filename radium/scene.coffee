class Scene
	constructor: (@engine, @name) ->
		@instances = {}
		@surfaces = []
		@dirty = true # Triggers first draw
		@last_instance_id = 100
		@active = false
		@width = 800
		@height = 600
		@last_width = 800
		@last_height = 600
		
	addTargetSurface: (surface) =>
		@surfaces.push(surface)
		@engine.updateCanvasSize(surface, @width, @height)
		$(surface).on("mousemove.radium", (event) =>
			canvas_pos = surface.getBoundingClientRect()
			@mouse_x = (event.clientX - canvas_pos.left) | 0
			@mouse_y = (event.clientY - canvas_pos.top) | 0
			@checkMouseCollisions()
		)
		@checkActive()
		
	removeTargetSurface: (surface) =>
		@surfaces = @surfaces.filter (obj) -> obj isnt surface
		$(surface).off("mousemove.radium")
		@checkActive()
		
	checkActive: =>
		@active = (@surfaces.length > 0)
		
	iteration: =>
		if @width != @last_width or @height != @last_height
			@engine.updateCanvasSize(surface, @width, @height) for surface in @surfaces
			[@last_width, @last_height] = [@width, @height]
		
		for id, instance of @instances
			if instance.callEvent("step")
				@dirty = true
		
		if @dirty
			@redraw()
			@dirty = false
			
	redraw: =>
		for surface in @surfaces
			ctx = @engine.getSurface(surface)
			ctx.clearRect(0, 0, surface.width, surface.height);
			instance.callEvent("draw", {surface: surface}) for id, instance of @instances
		
	checkMouseCollisions: =>
		for id, instance of @instances
			collision = instance.checkPointCollision(@mouse_x, @mouse_y)
			
			if collision and not instance._moused_over
				instance.callEvent("mouseover")
				instance._moused_over = true
			else if not collision and instance._moused_over
				instance.callEvent("mouseout")
				instance._moused_over = false
		
	createInstance: (object, x = 0, y = 0) =>
		id = @last_instance_id += 1
		real_object = @engine.getObject(object)
		
		instance = window.Object.create(real_object)
		instance.x = x
		instance.y = y
		instance.id = id
		instance.scene = this
		@instances[id] = instance
		real_object.instances.push(instance)
		
		instance.callEvent("create")
		
		return instance
		
	changeScene: (scene) =>
		# This will change to a different scene, but inherit the target surfaces
		pass