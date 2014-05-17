$(->
	manager = new ResourceManager("easing/assets")
	engine = new Engine(manager)
	window.debug_engine = engine

	# Configure game assets
	manager.addImages([
		"images/cursor.png"
	])

	manager.prepare()
	manager.preload(null, ->
		engine.addCanvas($("#gamecanvas"));

		scene = engine.createScene("main")

		engine.createSprite("cursor", "images/cursor.png")

		cursor = engine.createObject("cursor")
		cursor.sprite = engine.getSprite("cursor")

		cursor.onClickGlobal = (event) ->
			@x = @engine.ease.quadInOut(@x, event.x - 41, 15)
			@y = @engine.ease.quadInOut(@y, event.y - 41, 15)

		cursor.onStep = ->
			return true

		scene.createInstance(cursor, 0, 0)

		engine.start()
	)
)
