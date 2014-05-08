Engine::draw =
	_startPath: (surface, options) =>
		surface = @getSurface(surface)
		
		if not options._is_text ? false
			surface.beginPath()
			
		return surface
	
	_finishPath: (surface, options) =>
		if options.stroke ? true
			surface.lineWidth = options.lineWidth?.value ? options.lineWidth ? options.pen?.lineWidth?.value ? options.pen?.lineWidth ? 1
			surface.strokeStyle = options.lineColor ? options.pen?.lineColor ? "black"
			
			if options._is_text ? false
				surface.strokeText(options.text, options.x, options.y)
			else
				surface.stroke()
			
		if options.fill ? false
			surface.fillStyle = options.fillColor ? options.pen?.fillColor ? "white"
			
			if options._is_text ? false
				surface.fillText(options.text, options.x, options.y)
			else
				surface.fill()
	
	_getTextWidth: (surface, text, options) =>
		@_applyTextContext(surface, options)
		width = surface.measureText(text).width
		surface.restore()
		return width
	
	_applyTextContext: (surface, options) =>
		font_family = options.font ? "sans-serif"
		font_size = options.size?.value ? options.size ? 16
		font_weight = options.weight ? "normal"
		font_style = options.style ? "normal"
		scale = options.scale?.value ? options.scale ? 1
		
		surface.save()
		surface.font = "#{font_weight} #{font_style} #{font_size}px '#{font_family}'"
		surface.globalAlpha = options.alpha?.value ? options.alpha ? 1
		surface.scale(scale, scale)
	
	line: (x1, y1, x2, y2, options = {}, surface = "") =>
		# Ease-able properties
		x1 = x1.value ? x1
		y1 = y1.value ? y1
		x2 = x2.value ? x2
		y2 = y2.value ? y2
		
		surface = @_startPath(surface, options)
		surface.moveTo(x1, y1)
		surface.lineTo(x2, y2)
		@_finishPath(surface, options)
	
	rectangle: (x1, y1, x2, y2, options = {}, surface = "") =>
		# Ease-able properties
		x1 = x1.value ? x1
		y1 = y1.value ? y1
		x2 = x2.value ? x2
		y2 = y2.value ? y2
		
		surface = @_startPath(surface, options)
		surface.rect(x1, y1, x2 - x1, y2 - y1)
		@_finishPath(surface, options)
		
	boxEllipse: (x1, y1, x2, y2, options = {}, surface = "") =>
		# Ease-able properties
		x1 = x1.value ? x1
		y1 = y1.value ? y1
		x2 = x2.value ? x2
		y2 = y2.value ? y2
		
		x = (x1 + x2) / 2;
		y = (y1 + y2) / 2;
		rx = (x2 - x1) / 2;
		ry = (y2 - y1) / 2;
		@radiusEllipse(x, y, rx, ry, options, surface)
		
	radiusEllipse: (x, y, rx, ry, options = {}, surface = "") =>
		# Ease-able properties
		x = x.value ? x
		y = y.value ? y
		rx = rx.value ? rx
		ry = ry.value ? ry
		
		surface = @_startPath(surface, options)
		
		step = options.step?.value ? options.step ? 0.1
		
		if rx == ry
			surface.arc(x, y, rx, 0, 2 * Math.PI, false)
		else
			surface.moveTo(x + rx, y)
			
			for i in [0 .. (Math.PI * 2 + step)]
				surface.lineTo(x + (Math.cos(i) * rx), y + (Math.sin(i) * ry))
				
		@_finishPath(surface, options)
		
	boxPolygon: (x1, y1, x2, y2, sides, options = {}, surface = "") =>
		pass # TODO
		
	radiusPolygon: (x, y, r, sides, options = {}, surface = "") =>
		pass # TODO
		
	text: (x, y, text, options = {}, surface = "") =>
		# Ease-able properties
		x = x.value ? x
		y = y.value ? y
		
		# Defaults
		options.alignment ?= "left"
		options.scale = options.scale?.value ? options.scale ? 1
		options._is_text = true
		options.text = text
		options.y = y
		
		# Text needs different default color settings from other shapes...
		options.fill ?= true
		options.fillColor ?= "black"
		options.stroke ?= false
		
		# X coordinate will be calculated depending on alignment
		if alignment == "left"
			options.x = x
		else
			text_width = @_getTextWidth(text, options)
			
			if alignment == "center"
				options.x = x - ((text_width / 2) * scale * scale)
			else if alignment == "right"
				options.x = x - text_width # FIXME: Possibly broken wrt scale?
		
		@_startPath(surface, options)
		@_finishPath(surface, options)
		
		# This is to avoid scale from affecting anything else
		surface.restore()