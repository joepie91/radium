$(->
	manager = new ResourceManager("gemswap/assets")
	engine = new Engine(manager)
	window.debug_engine = engine
	###
	# Configure pre-loading assets
	manager.addImages([
		"images/loading_screen.png"
	], true)
	###

	# Configure game assets
	manager.addImages([
		"images/cursor.png"
		"images/diamond.png"
		"images/diamond_inverted.png"
		"images/diamond_shimmer.png"
		"images/yellow.png"
		"images/yellow_inverted.png"
		"images/yellow_shimmer.png"
		"images/blue.png"
		"images/blue_inverted.png"
		"images/blue_shimmer.png"
	])

	###
	manager.addSounds([
		"sfx/match.wav"
		"sfx/swap.wav"
	])
	###

	manager.prepare()
	manager.preload(null, ->
		engine.addCanvas($("#gamecanvas"));

		scene = engine.createScene("main")

		engine.createSprite("cursor", "images/cursor.png")
		
		engine.createSprite("diamond", "images/diamond.png")
		engine.createSprite("diamond_inverted", "images/diamond_inverted.png")
		engine.createSprite("diamond_shimmer", "images/diamond_shimmer.png")

		engine.createSprite("yellow", "images/yellow.png")
		engine.createSprite("yellow_inverted", "images/yellow_inverted.png")
		engine.createSprite("yellow_shimmer", "images/yellow_shimmer.png")
		
		engine.createSprite("blue", "images/blue.png")
		engine.createSprite("blue_inverted", "images/blue_inverted.png")
		engine.createSprite("blue_shimmer", "images/blue_shimmer.png")

		cursor = engine.createObject("cursor")
		cursor.sprite = engine.getSprite("cursor")
		
		diamond = engine.createObject("diamond")
		diamond.sprite = engine.getSprite("diamond")
		diamond.draw_sprite = false
		
		diamond.onCreate = ->
			@fade_value = 0.3
			@shimmer_value = @engine.ease.circInOut(0, 0.8, engine.random.number(200, 350), null, true, true)
			@gem_type = @engine.random.pick("diamond", "yellow", "blue")
		
		diamond.onStep = ->
			return true
		
		diamond.onDraw = ->
			@engine.getSprite(@gem_type).draw(@x, @y)
			
			@engine.getSprite("#{@gem_type}_inverted").draw(@x, @y, {
				alpha: @fade_value
			})
			
			@engine.getSprite("#{@gem_type}_shimmer").draw(@x - 14, @y - 14, {
				alpha: @shimmer_value
			})
		
		diamond.onMouseOver = ->
			@fade_value = @engine.ease.quadInOut(0.3, 0.7, 10, @engine.ease.bounceOut(0.7, 0.3, 65))
			
			cursor = @engine.getObject("cursor").getInstances()[0]
			cursor.x = @engine.ease.quadInOut(cursor.x, @x - 9, 8)
			cursor.y = @engine.ease.quadInOut(cursor.y, @y - 9, 8)
		
		for x in [10 .. 728] by 80
			for y in [10 .. 550] by 80
				scene.createInstance(diamond, x, y)
				
		cursor.onStep = ->
			$("#debug").html("Mouse coords: #{@scene.mouse_x} / #{@scene.mouse_y}<br>Frameskip: #{@engine.frameskip}")
				
		scene.createInstance(cursor, 0, 0)

		engine.start()
	)
)
