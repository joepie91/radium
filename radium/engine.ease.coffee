Engine::ease = 
	_calculateElasticValues: (amplitude, period, change, inout = false) =>
		if !period?
			if inout
				period = duration * (0.3 * 1.5)
			else
				period = duration * 0.3
		
		if !amplitude? or amplitude < Math.abs(change)
			amplitude = change
			overshoot = period / 4
		else
			overshoot = period / (2 * Math.PI) * Math.asin(change / amplitude)
		
		return [amplitude, period, change]
			
	backIn: (start, end, duration, infinite = false, overshoot = 1.70158) =>
		return new Ease("backIn", infinite, start, end, @current_frame, duration, overshoot)
	backOut: (start, end, duration, infinite = false, overshoot = 1.70158) =>
		return new Ease("backOut", infinite, start, end, @current_frame, duration, overshoot)
	backInOut: (start, end, duration, infinite = false, overshoot = 1.70158) =>
		return new Ease("backInOut", infinite, start, end, @current_frame, duration, overshoot)
	bounceOut: (start, end, duration, infinite = false) =>
		return new Ease("bounceOut", infinite, start, end, @current_frame, duration)
	bounceIn: (start, end, duration, infinite = false) =>
		return new Ease("bounceIn", infinite, start, end, @current_frame, duration)
	bounceInOut: (start, end, duration, infinite = false) =>
		return new Ease("bounceInOut", infinite, start, end, @current_frame, duration)
	circOut: (start, end, duration, infinite = false) =>
		return new Ease("circOut", infinite, start, end, @current_frame, duration)
	circIn: (start, end, duration, infinite = false) =>
		return new Ease("circIn", infinite, start, end, @current_frame, duration)
	circInOut: (start, end, duration, infinite = false) =>
		return new Ease("circInOut", infinite, start, end, @current_frame, duration)
	cubicOut: (start, end, duration, infinite = false) =>
		return new Ease("cubicOut", infinite, start, end, @current_frame, duration)
	cubicIn: (start, end, duration, infinite = false) =>
		return new Ease("cubicIn", infinite, start, end, @current_frame, duration)
	cubicInOut: (start, end, duration, infinite = false) =>
		return new Ease("cubicInOut", infinite, start, end, @current_frame, duration)
	elasticOut: (start, end, duration, infinite = false, amplitude = null, period = null) =>
		[amplitude, period, change] = @_calculateElasticValues(amplitude, period, end - start)
		end = start + change
		return new Ease("elasticOut", infinite, start, end, @current_frame, duration)
	elasticIn: (start, end, duration, infinite = false, amplitude = null, period = null) =>
		[amplitude, period, change] = @_calculateElasticValues(amplitude, period, end - start)
		end = start + change
		return new Ease("elasticIn", infinite, start, end, @current_frame, duration)
	elasticInOut: (start, end, duration, infinite = false, amplitude = null, period = null) =>
		[amplitude, period, change] = @_calculateElasticValues(amplitude, period, end - start, true)
		end = start + change
		return new Ease("elasticInOut", infinite, start, end, @current_frame, duration)
	expoOut: (start, end, duration, infinite = false) =>
		return new Ease("expoOut", infinite, start, end, @current_frame, duration)
	expoIn: (start, end, duration, infinite = false) =>
		return new Ease("expoIn", infinite, start, end, @current_frame, duration)
	expoInOut: (start, end, duration, infinite = false) =>
		return new Ease("expoInOut", infinite, start, end, @current_frame, duration)
	linearNone: (start, end, duration, infinite = false) =>
		return new Ease("linearNone", infinite, start, end, @current_frame, duration)
	linearOut: (start, end, duration, infinite = false) =>
		return new Ease("linearNone", infinite, start, end, @current_frame, duration)
	linearIn: (start, end, duration, infinite = false) =>
		return new Ease("linearNone", infinite, start, end, @current_frame, duration)
	linearInOut: (start, end, duration, infinite = false) =>
		return new Ease("linearNone", infinite, start, end, @current_frame, duration)
	quadOut: (start, end, duration, infinite = false) =>
		return new Ease("quadOut", infinite, start, end, @current_frame, duration)
	quadIn: (start, end, duration, infinite = false) =>
		return new Ease("quadIn", infinite, start, end, @current_frame, duration)
	quadInOut: (start, end, duration, infinite = false) =>
		return new Ease("quadInOut", infinite, start, end, @current_frame, duration)
	quartOut: (start, end, duration, infinite = false) =>
		return new Ease("quartOut", infinite, start, end, @current_frame, duration)
	quartIn: (start, end, duration, infinite = false) =>
		return new Ease("quartIn", infinite, start, end, @current_frame, duration)
	quartInOut: (start, end, duration, infinite = false) =>
		return new Ease("quartInOut", infinite, start, end, @current_frame, duration)
	sineOut: (start, end, duration, infinite = false) =>
		return new Ease("sineOut", infinite, start, end, @current_frame, duration)
	sineIn: (start, end, duration, infinite = false) =>
		return new Ease("sineIn", infinite, start, end, @current_frame, duration)
	sineInOut: (start, end, duration, infinite = false) =>
		return new Ease("sineInOut", infinite, start, end, @current_frame, duration)
	
	
class Ease
	# Port based on https://github.com/jimjeffers/Easie. I don't think this qualifies as a "bad thing" :)
	constructor: (type, @infinite, @start, end, @start_frame, @duration, @params...) ->
		@func = this[type]
		@change = end - @start
		@value = @start
		@finished = false
		# TODO: Investigate whether JS engines cache deterministic outcomes by themselves. If not,
		#       the below could provide some performance gain.
		#@bounce_constant_1 = 1 / 2.75
		#@bounce_constant_2 = 2 / 2.75
		#@bounce_constant_3 = 2.5 / 2.75
		
	updateValue: (current_frame) =>
		@value = @func(current_frame - @start_frame)
		
	backIn: (time) =>
		time = time / @duration
		overshoot = @params[0]
		return @change * time * time * ((overshoot + 1) * time - overshoot) + @start
	
	backOut: (time) =>
		time = time / @duration - 1
		overshoot = @params[0]
		return @change * (time * time * ((overshoot + 1) * time + overshoot) + 1) + @start
	
	backInOut: (time) =>
		time = time / (@duration / 2)
		overshoot = @params[0] * 1.525
		
		if time < 1
			return @change / 2 * (time * time * ((overshoot + 1) * time - overshoot)) + @start
		else
			time -= 2
			return @change / 2 * (time * time * ((overshoot + 1) * time + overshoot) + 2) + @start
		
	bounceOut: (time, start = null) =>
		time = time / @duration
		start = start ? @start
		
		if time < 1 / 2.75
			return @change * (7.5625 * time * time) + start
		else if time < 2 / 2.75
			time = time - (1.5 / 2.75)
			return @change * (7.5625 * time * time + 0.75) + start
		else if time < 2.5 / 2.75
			time = time - (2.25 / 2.75)
			return @change * (7.5625 * time * time + 0.9375) + start
		else
			time = time - (2.625 / 2.75)
			return @change * (7.5625 * time * time + 0.984375) + start
			
	bounceIn: (time, start = null) =>
		start = start ? @start
		return @change - @bounceOut(@duration - time, 0) + start
	
	bounceInOut: (time) =>
		if time < @duration / 2
			return @bounceIn(time * 2, 0) + @start
		else
			return @bounceOut(time * 2 - @duration, 0) + @start
	
	circIn: (time) =>
		time = time / @duration
		return -@change * (Math.sqrt(1 - time * time) - 1) + @start
	
	circOut: (time) =>
		time = time / @duration - 1
		return @change * Math.sqrt(1 - time * time) + @start
	
	circInOut: (time) =>
		time = time / (@duration / 2)

		if time < 1
			return -@change / 2 * (Math.sqrt(1 - time * time) - 1) + @start
		else
			time = time - 2
			return @change / 2 * (Math.sqrt(1 - time * time) + 1) + @begin
	