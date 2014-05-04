class Sprite
	constructor: (@engine, @name, @image) ->
		pass
		
	draw: (x, y, options = {}, surface = "") =>
		surface = @engine.getSurface(surface)
		# TODO: Options.
		surface.globalAlpha = options.alpha ? 1
		surface.drawImage(@image, x, y)
		
	getSize: =>
		return {width: @image.width, height: @image.height}