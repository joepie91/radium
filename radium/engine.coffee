window.pass = undefined # This will give us Python-like noop calls

class Engine
	constructor: (@resource_manager) ->
		@canvases = {}
		@fps = 45
		@last_frameskip_collection = Math.floor(Date.now())
		@frameskip = 0
		@current_frameskip = 0
		
		@scenes = {}
		@objects = {}
		@sounds = {}
		@sprites = {}
		@tilesets = {}

	addCanvas: (canvas, label = "") =>
		@canvases[label] = util.unpackElement(canvas)

	createSurface: (label) =>
		@canvases[label] = document.createElement("canvas")
	
	getSurface: (label) =>
		if typeof label == "string"
			return @canvases[label]?.getContext("2d")
		else if label.tagName == "CANVAS"
			return label.getContext("2d")
		else
			return label
	
	updateCanvasSize: (canvas, w, h) =>
		canvas.width = w
		canvas.height = h
		canvas.style.width = "#{w}px"
		canvas.style.height = "#{h}px"
	
	start: () =>
		@initial_scene.addTargetSurface(@canvases[""])
		@loop()
	
	loop: () =>
		@iteration()

	iteration: () =>
		# Calculation of next frame and frameskip collection check
		frame_interval = (1000 / @fps)

		current_frame = Date.now()
		next_frame = current_frame + frame_interval
		
		if Math.floor(current_frame) > @last_frameskip_collection
			@frameskip = @current_frameskip
			@current_frameskip = 0
			@last_frameskip_collection = Math.floor(current_frame)

		# Actual iteration code
		scene.iteration() for name, scene of @scenes when scene.active
		
		# Frameskip check and triggering next iteration
		if Date.now() < next_frame
			setTimeout(@iteration, (next_frame - Date.now()))
		else
			# Frameskip!
			overtime = Date.now() - next_frame
			@current_frameskip += Math.floor(overtime / frame_interval)
			belated_timeout = overtime % frame_interval
			setTimeout(@iteration, belated_timeout)
			
	setInitialScene: (scene) =>
		@initial_scene = scene
		
	setPreloadScene: (scene) =>
		@preload_scene = scene
			
	createScene: (name) =>
		scene = new Scene(this, name)
		@initial_scene ?= scene
		@scenes[name] = scene
		
	createObject: (name) =>
		@objects[name] = new Object(this, name)
		
	createSound: (name, sound) =>
		@sounds[name] = new Sound(this, name, @resource_manager.getSound(sound))
		
	createSprite: (name, image) =>
		console.log("gget", @resource_manager.getImage(image))
		@sprites[name] = new Sprite(this, name, @resource_manager.getImage(image))
		
	createTileset: (name, image, tile_width, tile_height) =>
		@tilesets[name] = new Tileset(this, name, @resource_manager.getImage(image), tile_width, tile_height)
		
	getScene: (name) =>
		if typeof name == "string" then @scenes[name] else name
		
	getObject: (name) =>
		if typeof name == "string" then @objects[name] else name
		
	getSound: (name) =>
		if typeof name == "string" then @sounds[name] else name
		
	getSprite: (name) =>
		if typeof name == "string" then @sprites[name] else name
		
	getTileset: (name) =>
		if typeof name == "string" then @tilesets[name] else name