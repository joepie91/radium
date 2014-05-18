$(->
	manager = new ResourceManager("assets")
	engine = new Engine(manager)
	window.debug_engine = engine
	
	# Configure game assets
	manager.addImages([
		"ball.png"
	])
	
	manager.prepare ->
		# Set up the engine
		engine.addCanvas($("#gamecanvas"));
		engine.setInitialScene(engine.createScene("main"))
		
		manager.load ->
			# Game asset initialization...
			engine.createSprites({
				"ball": "ball.png",
			})
			
			# Object definitions
			ball = engine.createObject("ball")
			ball.sprite = engine.getSprite("ball")
			
			ball.onStep = ->
				return true
			
			ball.onClickGlobal = (event) ->
				@x = @engine.ease.quadInOut(@x, event.x - 41, 35)
				@y = @engine.ease.quadInOut(@y, event.y - 41, 35)
			
			# Scene configuration
			engine.getScene("main").onLoad = ->
				# Actual game initialization
				@createInstance(ball, 0, 0)
				
			# Let's go!
			engine.start()
			
)
