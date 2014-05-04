$(->
	manager = new ResourceManager("gemswap/assets")
	engine = new Engine(manager)

	###
	# Configure pre-loading assets
	manager.addImages([
		"images/loading_screen.png"
	], true)
	###

	# Configure game assets
	manager.addImages([
		"images/diamond.png"
		"images/diamond_inverted.png"
		"images/diamond_shimmer.png"
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

		engine.createSprite("diamond", "images/diamond.png")
		engine.createSprite("diamond_inverted", "images/diamond_inverted.png")
		engine.createSprite("diamond_shimmer", "images/diamond_shimmer.png")

		diamond = engine.createObject("diamond")
		diamond.sprite = engine.getSprite("diamond")
		
		diamond.onCreate = ->
			@fade_step = 0.045
			@fade_current_step = @fade_step
			@fade_value = 0
			@fade_decay_current = 9999 # Disable by default
			@fade_decay_max = 8
			
			@shimmer_step = 0.006
			@shimmer_current_step = @shimmer_step
			@shimmer_value = 0
		
		diamond.onStep = ->
			if @fade_decay_current < Math.pow(2, @fade_decay_max)
				@fade_value += @fade_current_step
				
				max = 1.5 / @fade_decay_current
				
				if @fade_value > Math.min(max, 1)
					@fade_value = Math.min(max, 1)
					@fade_current_step = -@fade_step

				if @fade_value <= 0
					@fade_value = 0
					@fade_decay_current *= 1.5
					@fade_current_step = @fade_step
				
			@shimmer_value += @shimmer_current_step
			
			if @shimmer_value > 0.7
				@shimmer_value = 0.7
				@shimmer_current_step = -@shimmer_step
			
			if @shimmer_value < 0
				@shimmer_value = 0
				@shimmer_current_step = @shimmer_step
			
			return true
		
		diamond.onDraw = ->
			@engine.getSprite("diamond_inverted").draw(@x, @y, {
				alpha: @fade_value
			})
			
			@engine.getSprite("diamond_shimmer").draw(@x - 14, @y - 14, {
				alpha: @shimmer_value
			})
		
		diamond.onMouseOver = ->
			console.log("mouseover")
			@fade_decay_current = 1
		
		scene.createInstance(diamond, 20, 20)

		engine.start()
	)
)