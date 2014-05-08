Engine::timing =
	startTimer: (frames, callback, name = null, repeat = false) =>
		timer = new Timer(frames, callback, repeat)
		if name?
			@named_timers[name] = timer
		else
			@unnamed_timers.push(timer)
		
	stopTimer: (name)
		@timers[name].stop()
		
class Timer
	constructor: (@frames, @callback, @repeat) =>
		@current_frame = 0
		@finished = false
		
	step: =>
		if @current_frame >= @frames
			@callback()
			
			if repeat
				@current_frame = 0
			else
				@finished = true
			
	skip: (frames) =>
		@current_frame += frames
		
	stop: =>
		@finished = true