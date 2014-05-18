(function () {$(function() {
  var engine, manager;
  manager = new ResourceManager("gemswap/assets");
  engine = new Engine(manager);
  window.debug_engine = engine;

  /*
  	 * Configure pre-loading assets
  	manager.addImages([
  		"images/loading_screen.png"
  	], true)
   */
  manager.addImages(["images/cursor.png", "images/diamond.png", "images/diamond_inverted.png", "images/diamond_shimmer.png", "images/yellow.png", "images/yellow_inverted.png", "images/yellow_shimmer.png", "images/blue.png", "images/blue_inverted.png", "images/blue_shimmer.png"]);

  /*
  	manager.addSounds([
  		"sfx/match.wav"
  		"sfx/swap.wav"
  	])
   */
  return manager.prepare(function() {
    engine.addCanvas($("#gamecanvas"));
    engine.setPreloadScene(engine.createScene("loader"));
    engine.setInitialScene(engine.createScene("main"));
    return manager.load(function() {
      var cursor, diamond;
      engine.createSprite("cursor", "images/cursor.png");
      engine.createSprite("diamond", "images/diamond.png");
      engine.createSprite("diamond_inverted", "images/diamond_inverted.png");
      engine.createSprite("diamond_shimmer", "images/diamond_shimmer.png");
      engine.createSprite("yellow", "images/yellow.png");
      engine.createSprite("yellow_inverted", "images/yellow_inverted.png");
      engine.createSprite("yellow_shimmer", "images/yellow_shimmer.png");
      engine.createSprite("blue", "images/blue.png");
      engine.createSprite("blue_inverted", "images/blue_inverted.png");
      engine.createSprite("blue_shimmer", "images/blue_shimmer.png");
      cursor = engine.createObject("cursor");
      cursor.sprite = engine.getSprite("cursor");
      cursor.onStep = function() {
        return $("#debug").html("Mouse coords: " + this.scene.mouse_x + " / " + this.scene.mouse_y + "<br>Frameskip: " + this.engine.frameskip);
      };
      diamond = engine.createObject("diamond");
      diamond.sprite = engine.getSprite("diamond");
      diamond.draw_sprite = false;
      diamond.onCreate = function() {
        this.fade_value = 0.3;
        this.shimmer_value = this.engine.ease.circInOut(0, 0.8, engine.random.number(200, 350), null, true, true);
        return this.gem_type = this.engine.random.pick("diamond", "yellow", "blue");
      };
      diamond.onStep = function() {
        return true;
      };
      diamond.onDraw = function() {
        this.engine.getSprite(this.gem_type).draw(this.x, this.y);
        this.engine.getSprite("" + this.gem_type + "_inverted").draw(this.x, this.y, {
          alpha: this.fade_value
        });
        return this.engine.getSprite("" + this.gem_type + "_shimmer").draw(this.x - 14, this.y - 14, {
          alpha: this.shimmer_value
        });
      };
      diamond.onMouseOver = function() {
        this.fade_value = this.engine.ease.quadInOut(0.3, 0.7, 10, this.engine.ease.bounceOut(0.7, 0.3, 65));
        cursor = this.engine.getObject("cursor").getInstances()[0];
        cursor.x = this.engine.ease.quadInOut(cursor.x, this.x - 9, 8);
        return cursor.y = this.engine.ease.quadInOut(cursor.y, this.y - 9, 8);
      };
      engine.getScene("loader").onLoad = function() {
        var loader;
        loader = engine.createObject("loader");
        loader.onStep = function() {
          return true;
        };
        loader.onDraw = function() {
          engine.draw.rectangle(0, 0, 800 * manager.file_progress, 64, {
            fillColor: "#CCCCCC"
          });
          return engine.draw.rectangle(0, 64, 800 * manager.total_progress, 128, {
            fillColor: "#AAAAAA"
          });
        };
        return this.createInstance(loader, 0, 0);
      };
      engine.getScene("main").onLoad = function() {
        var x, y, _i, _results;
        this.createInstance(cursor, 0, 0);
        _results = [];
        for (x = _i = 10; _i <= 728; x = _i += 80) {
          _results.push((function() {
            var _j, _results1;
            _results1 = [];
            for (y = _j = 10; _j <= 550; y = _j += 80) {
              _results1.push(this.createInstance(diamond, x, y));
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };
      return engine.start();
    });
  });
});
})();