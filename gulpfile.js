var gulp = require('gulp');
var gutil = require('gulp-util');
var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var rename = require('gulp-rename');
var coffee = require('gulp-coffee');
var addsrc = require('gulp-add-src');
var cache = require('gulp-cached');
var remember = require('gulp-remember');
var header = require('gulp-header');
var footer = require('gulp-footer');
var plumber = require('gulp-plumber');

/* Engine build tasks */
engine = {
	source: "radium/*.coffee",
	external: ["external/jquery-2.1.1.js", "external/preloadjs-0.4.1.min.js", "external/soundjs-0.5.2.min.js"],
	target: {
		path: "compiled",
		name: "radium.js",
		minName: "radium.min.js"
	}
}

gulp.task('dev-engine', function() {
	return gulp.src(engine.source)
		.pipe(plumber())
		.pipe(cache("engine-coffee"))
		.pipe(coffee({bare: true}).on('error', gutil.log)).on('data', gutil.log)
		.pipe(remember("engine-coffee"))
		.pipe(concat("radium.coffee.js"))
		.pipe(header('(function () {'))
		.pipe(footer('; window.ResourceManager = ResourceManager; window.Engine = Engine; })();'))
		.pipe(addsrc(engine.external))
		.pipe(concat("radium.concat.js"))
		.pipe(rename(engine.target.name))
		.pipe(gulp.dest(engine.target.path));
});

gulp.task("prod-engine", ["dev-engine"], function(){
	return gulp.src(engine.target.path + "/" + engine.target.name)
		.pipe(uglify())
		.pipe(rename(engine.target.minName))
		.pipe(gulp.dest(engine.target.path));
});

/* Sample game build tasks */
gemswap = {
	source: "gemswap/*.coffee",
	external: "",
	target: {
		path: "gemswap",
		name: "gemswap.js",
		minName: "gemswap.min.js"
	}
}

gulp.task('dev-gemswap', function() {
	return gulp.src(gemswap.source)
		.pipe(plumber())
		.pipe(cache("gemswap-coffee"))
		.pipe(coffee({bare: true}).on('error', gutil.log)).on('data', gutil.log)
		.pipe(remember("gemswap-coffee"))
		.pipe(concat("gemswap.coffee.js"))
		.pipe(header('(function () {'))
		.pipe(footer('})();'))
		.pipe(addsrc(gemswap.external))
		.pipe(concat("gemswap.concat.js"))
		.pipe(rename(gemswap.target.name))
		.pipe(gulp.dest(gemswap.target.path));
});

gulp.task("prod-gemswap", ["dev-gemswap"], function(){
	return gulp.src(gemswap.target.path + "/" + gemswap.target.name)
		.pipe(uglify())
		.pipe(rename(gemswap.target.minName))
		.pipe(gulp.dest(gemswap.target.path));
});

/* Watcher */
gulp.task('watch', function () {
	targets = {
		"gemswap": gemswap,
		"engine": engine
	}

	for(name in targets)
	{
		var watcher = gulp.watch(targets[name].source, ['dev-' + name]);
		watcher.on('change', function (event) {
			if (event.type === 'deleted')
			{
				delete cache.caches[name + '-coffee'][event.path];
				remember.forget(name + '-coffee', event.path);
			}
		});
	}
});

gulp.task("dev", ["dev-engine", "dev-gemswap"]);
gulp.task("prod", ["prod-engine", "prod-gemswap"]);
gulp.task("default", ["prod"]);
