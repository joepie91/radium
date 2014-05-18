class ResourceManager
	constructor: (@base_path = "") ->
		@resources = 
			stage1_images: []
			stage1_sounds: []
			stage1_scripts: []
			stage1_data: []
			images: []
			sounds: []
			scripts: []
			data: []
			
		@resource_objects =
			images: {}
			sounds: {}
			scripts: {}
			data: {}
			
		@base_path = util.stripRight(@base_path, "/") + "/"
			
		@files_loaded = 0
		@files_total = 0
		@total_progress = 0
		@file_progress = 0

	joinPath: (path) =>
		if @base_path == "" then path else @base_path + path

	addImage: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_images.push(path)
		else
			@resources.images.push(path)

	addSound: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_audio.push(path)
		else
			@resources.sounds.push(path)

	addScript: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_scripts.push(path)
		else
			@resources.scripts.push(path)
			
	addDataFile: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_data.push(path)
		else
			@resources.data.push(path)

	addImages: (paths, first_stage = false) =>
		@addImage(path, first_stage) for path in paths
			
	addScripts: (paths, first_stage = false) =>
		@addScript(path, first_stage) for path in paths
			
	addSounds: (paths, first_stage = false) =>
		@addSound(path, first_stage) for path in paths
			
	addDataFiles: (paths, first_stage = false) =>
		@addDataFile(path, first_stage) for path in paths
			
	getImage: (path) =>
		return @resource_objects.images[@joinPath(path)]
			
	updateProgress: (event) =>
		console.log(event)
		@file_progress = event.loaded / event.total
		
	handleFinishedFile: (event) =>
		switch event.item.type
			when createjs.LoadQueue.IMAGE then @resource_objects.images[event.item.src] = event.result
			when createjs.LoadQueue.JAVASCRIPT then @resource_objects.scripts[event.item.src] = event.result
			when createjs.LoadQueue.SOUND then @resource_objects.sounds[event.item.src] = event.result
			when createjs.LoadQueue.JSON then @resource_objects.data[event.item.src] = event.result
		
		if @current_stage == 2
			@files_loaded += 1
			@total_progress = @files_loaded / @files_total
			
	handleComplete: (event) =>
		stage = @current_stage
		
		@finished_callback()
		
		if stage == 1
			@engine?.switchPreloadScene()
		else if stage == 2
			@engine?.switchInitialScene()
		
	doPreload: (stage, progress_callback) =>
		@current_stage = stage
		
		if stage == 1
			images = @resources.stage1_images
			scripts = @resources.stage1_scripts
			sounds = @resources.stage1_sounds
			data_files = @resources.stage1_data
		else
			images = @resources.images
			scripts = @resources.scripts
			sounds = @resources.sounds
			data_files = @resources.data
			
		@queue = new createjs.LoadQueue(true, @base_path)
		
		for image in images
			@files_total += 1
			@queue.loadFile({src: image, type: createjs.LoadQueue.IMAGE}, false)
			
		for script in scripts
			@files_total += 1
			@queue.loadFile({src: script, type: createjs.LoadQueue.JAVASCRIPT}, false)
			
		for sound in sounds
			@files_total += 1
			@queue.loadFile({src: sound, type: createjs.LoadQueue.SOUND}, false)
			
		for data_file in data_files
			@files_total += 1
			@queue.loadFile({src: data_file, type: createjs.LoadQueue.JSON})
		
		@queue.on("fileprogress", progress_callback)
		@queue.on("fileload", @handleFinishedFile)
		@queue.on("complete", @handleComplete)
		
		@queue.load()
		
	prepare: (finished_callback = (->)) =>
		# This performs a stage 1 preload, loading the initial assets required for displaying the preload screen.
		@finished_callback = finished_callback.bind(this)
		@doPreload(1, (->))

	load: (finished_callback = (->)) =>
		# This performs the stage 2 preload; it will load the actual game assets.
		@finished_callback = finished_callback.bind(this)
		@doPreload(2, @updateProgress)
		