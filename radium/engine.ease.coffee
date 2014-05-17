Engine::ease = 
	_calculateElasticValues: (duration, amplitude, period, change, inout = false) ->
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
		
		return [amplitude, period, change, overshoot]
			
	backIn: (start, end, duration, next = null, infinite = false , invert_repeat = false, overshoot = 1.70158) ->
		return new Ease(this.engine, "backIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next, overshoot)
	backOut: (start, end, duration, next = null, infinite = false , invert_repeat = false, overshoot = 1.70158) ->
		return new Ease(this.engine, "backOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next, overshoot)
	backInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false, overshoot = 1.70158) ->
		return new Ease(this.engine, "backInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next, overshoot)
	bounceOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "bounceOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	bounceIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "bounceIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	bounceInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "bounceInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	circOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "circOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	circIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "circIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	circInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "circInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	cubicOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "cubicOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	cubicIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "cubicIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	cubicInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "cubicInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	elasticOut: (start, end, duration, next = null, infinite = false , invert_repeat = false, amplitude = null, period = null) ->
		[amplitude, period, change, overshoot] = @_calculateElasticValues(duration, amplitude, period, end - start)
		end = start + change
		return new Ease(this.engine, "elasticOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next, amplitude, period, overshoot)
	elasticIn: (start, end, duration, next = null, infinite = false , invert_repeat = false, amplitude = null, period = null) ->
		[amplitude, period, change, overshoot] = @_calculateElasticValues(duration, amplitude, period, end - start)
		end = start + change
		return new Ease(this.engine, "elasticIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next, amplitude, period, overshoot)
	elasticInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false, amplitude = null, period = null) ->
		[amplitude, period, change, overshoot] = @_calculateElasticValues(duration, amplitude, period, end - start, true)
		end = start + change
		return new Ease(this.engine, "elasticInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next, amplitude, period, overshoot)
	expoOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "expoOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	expoIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "expoIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	expoInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "expoInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	linearNone: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "linearNone", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	linearOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "linearNone", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	linearIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "linearNone", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	linearInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "linearNone", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	quadOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "quadOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	quadIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "quadIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	quadInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "quadInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	quartOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "quartOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	quartIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "quartIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	quartInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "quartInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	sineOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "sineOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	sineIn: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "sineIn", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	sineInOut: (start, end, duration, next = null, infinite = false , invert_repeat = false) ->
		return new Ease(this.engine, "sineInOut", infinite, start, end, @engine.current_frame, duration, invert_repeat, next)
	
	
class Ease
	# Port based on https://github.com/jimjeffers/Easie. I don't think this qualifies as a "bad thing" :)
	constructor: (@engine, @type, @infinite, @start, end, @start_frame, @duration, @invert_repeat, @next, @params...) ->
		@func = this[@type]
		@change = end - @start
		@value = @start
		@last_updated = @start_frame
		@finished = false
		# TODO: Investigate whether JS engines cache deterministic outcomes by themselves. If not,
		#       the below could provide some performance gain.
		#@bounce_constant_1 = 1 / 2.75
		#@bounce_constant_2 = 2 / 2.75
		#@bounce_constant_3 = 2.5 / 2.75
		
	goToNext: =>
		@func = this[@next.type]
		@change = @next.change
		@value = @next.value
		@start_frame = @last_updated = @engine.current_frame
		@infinite = @next.infinite
		@start = @next.start
		@change = @next.change
		@invert_repeat = @next.invert_repeat
		@params = @next.params
		@duration = @next.duration
		@finished = false
		@next = @next.next
		
	updateValue: (current_frame) =>
		if current_frame >= @start_frame + @duration
			if @infinite
				@start_frame = current_frame
				if @invert_repeat
					@start = @start + @change
					@change = -@change
				@value = @start
			else if @next?
				@goToNext()	
			else
				@finished = true
				@value = @start + @change
		else
			@value = @func(current_frame - @start_frame)
		
	valueOf: =>
		if not @finished and @engine.current_frame > @last_updated
			@updateValue(@engine.current_frame)
			@last_updated = @engine.current_frame
		return @value
		
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
			return @change / 2 * (Math.sqrt(1 - time * time) + 1) + @start

	cubicIn: (time) =>
		time = time / @duration
		return @change * time * time * time + @start

	cubicOut: (time) =>
		time = time / @duration - 1
		return @change * (time * time * time + 1) + @start

	cubicInOut: (time) =>
		time = time / (@duration / 2)
		if time < 1
			return change / 2 * time * time * time + @start
		else
			time = time - 2
			return change / 2 * (time * time * time + 2) + begin

	elasticOut: (time) =>
		time = time / @duration
		amplitude = @params[0]
		period = @params[1]
		overshoot = @params[2]

		return (amplitude * Math.pow(2, -10 * time)) * Math.sin((time * @duration - overshoot) * (2 * Math.PI) / period) + @change + @start

	elasticIn: (time) =>
		time = time / @duration
		amplitude = @params[0]
		period = @params[1]
		overshoot = @params[2]

		return -(amplitude * Math.pow(2, -10 * time)) * Math.sin((time * @duration - overshoot) * (2 * Math.PI) / period) + @start

	elasticInOut: (time) =>
		time = time / (@duration / 2) - 1
		amplitude = @params[0]
		period = @params[1]
		overshoot = @params[2]

		if time < 1
			return -0.5 * (amplitude * Math.pow(2, -10 * time)) * Math.sin((time * @duration - overshoot) * ((2 * Math.PI) / period)) + @start
		else
			return amplitude * Math.pow(2, -10 * time) * Math.sin((time * @duration - overshoot) * (2 * Math.PI) / period) + @change + @start

	expoIn: (time) =>
		return @change * Math.pow(2, 10 * (time / @duration - 1)) + @start

	expoOut: (time) =>
		return @change * (-Math.pow(2, -10 * time / @duration) + 1) + @start

	expoInOut: (time) =>
		time = time / (@duration / 2)

		if time < 1
			return @change  / 2 * Math.pow(2, 10 * (time - 1)) + @start
		else
			return @change / 2 * (-Math.pow(2, -10 * (time - 1)) + 2) + @start

	linearNone: (time) =>
		return @change * time / @duration + @start

	quadIn: (time) =>
		time = time / @duration
		return @change * time * time + @start

	quadOut: (time) =>
		time = time / @duration
		return -@change * time * (time - 2) + @start

	quadInOut: (time) =>
		time = time / (@duration / 2)

		if time < 1
			return @change / 2 * time * time + @start
		else
			time = time - 1
			return -@change / 2 * (time * (time - 2) - 1) + @start


