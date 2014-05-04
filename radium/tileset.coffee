class Tileset
	constructor: (@engine, @name, @image, @tile_width, @tile_height) ->
		@tiles = {}
		
	tile: (x, y, precise = false, w = 0, h = 0) =>
		key = "#{x}/#{y}/#{w}/#{h}/" + if precise then 1 else 0
		@tiles[key] ? tiles[key] = new TilesetTile(@engine, this, x, y, precise, w, h)
	
class TilesetTile
	constructor: (@engine, @tileset, @x, @y, @precise = false, @w = 0, @h = 0) ->
		pass
		
	draw: (x, y) =>
		if @precise
			source_x = @x
			source_y = @y
			source_w = @w
			source_h = @h
		else
			source_x = @x * @tileset.tile_width
			source_y = @y * @tileset.tile_height
			source_w = @tileset.tile_width
			source_h = @tileset.tile_height
		
		surface = @engine.getSurface()
		# TODO: Options.
		surface.drawImage(source_x, source_y, source_width, source_height, x, y)
		
	getSize: =>
		return if @precise then {width: @w, height: @h} else {width: @tileset.tile_width, height: @tileset.tile_height}