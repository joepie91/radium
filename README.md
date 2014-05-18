# Radium

A game engine, under development. Currently being rewritten in Coffeescript.

## Setup

To install dependencies you need for developing on Radium: `npm install`

Note that `coffee-script` may fail to install; in that case, you'll need to install it manually (and you can ignore the error from the previous command): `sudo npm install -g coffee-script`

To run the build scripts in development mode, automatically recompiling both engine and sample game code as files are changed: `gulp watch`

To compile and minify engine and sample games for production: `gulp`

If you want more fine-grained control...

* `gulp dev` compiles everything in development mode (not minified)
* `gulp prod`, which `gulp` is an alias for, compiles everything in production mode (minified)
* `gulp dev-engine` compiles the engine in development mode
* `gulp prod-engine` compiles the engine in production mode
* `gulp dev-gemswap` compiles gemswap in development mode
* `gulp prod-gemswap` compiles gemswap in production mode

That's it!

## Documentation

None! Sorry, you'll have to wait for first release, or look at the samples/engine code.

## License

[WTFPL](http://www.wtfpl.net/) or [CC0](https://creativecommons.org/publicdomain/zero/1.0/), as usual.

## External libraries

This project uses the following external libraries:

* jQuery by the jQuery foundation, [MIT license](https://jquery.org/license/)
* PreloadJS by gSkinner.com, [MIT license](https://github.com/CreateJS/PreloadJS/blob/master/LICENSE)
* SoundJS by gSkinner.com, [MIT license](https://github.com/CreateJS/SoundJS/blob/master/LICENSE)