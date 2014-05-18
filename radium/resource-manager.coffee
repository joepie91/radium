class ResourceManager
	constructor: (@base_path = "") ->
		@resources = 
			stage1_images: []
			stage1_audio: []
			stage1_scripts: []
			images: []
			audio: []
			scripts: []
			
		@resource_objects =
			images: {}
			audio: {}
			scripts: {}

	joinPath: (path) =>
		if @base_path == "" then path else util.stripRight(@base_path, "/") + "/" + path

	addImage: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_images.push(@joinPath(path))
		else
			@resources.images.push(@joinPath(path))

	addSound: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_audio.push(@joinPath(path))
		else
			@resources.audio.push(@joinPath(path))

	addScript: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_scripts.push(@joinPath(path))
		else
			@resources.scripts.push(@joinPath(path))
			
	addDataFile: (path, first_stage = false) =>
		if first_stage
			@resources.stage1_data.push(@joinPath(path))
		else
			@resources.data.push(@joinPath(path))

	addImages: (paths, first_stage = false) =>
		@addImage(path, first_stage) for path in paths
			
	addScripts: (paths, first_stage = false) =>
		@addScript(path, first_stage) for path in paths
			
	addSounds: (paths, first_stage = false) =>
		@addSound(path, first_stage) for path in paths
			
	addDataFiles: (paths, first_stage = false) =>
		@addDataFile(path, first_stage) for path in paths
			
	getImage: (path) =>
		# FIXME: Do properly when PreloadJS is added
		console.log("objs", @resource_objects)
		console.log("path", path)
		return @resource_objects.images[@joinPath(path)]
			
	updateProgress: (event) =>
		pass
		
	do_preload: (stage, progress_callback, finished_callback) =>
		if stage == 1
			images = @resources.stage1_images
			scripts = @resources.stage1_scripts
			sounds = @resources.stage1_sounds
		else
			images = @resources.images
			scripts = @resources.scripts
			sounds = @resources.sounds
			
		for image in images
			obj = document.createElement("img")
			obj.src = image
			@resource_objects.images[image] = obj
			
		console.log("done stage " + stage)
		finished_callback()
		
	prepare: (finished_callback = (->)) =>
		# This performs a stage 1 preload, loading the initial assets required for displaying the preload screen.
		@do_preload(1, (->), finished_callback)

	load: () =>
		# This performs the stage 2 preload; it will load the actual game assets.
		@do_preload(2, @updateProgress, @onLoad?.bind(this) ? (->))
		