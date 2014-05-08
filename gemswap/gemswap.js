// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
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
    manager.prepare();
    return manager.preload(null, function() {
      var cursor, diamond, scene, x, y, _i, _j;
      engine.addCanvas($("#gamecanvas"));
      scene = engine.createScene("main");
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
      diamond = engine.createObject("diamond");
      diamond.sprite = engine.getSprite("diamond");
      diamond.draw_sprite = false;
      diamond.onCreate = function() {
        this.fade_value = 0;
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
        this.fade_value = this.engine.ease.circOut(0, 1, 10, this.engine.ease.bounceOut(1, 0, 35));
        cursor = this.engine.getObject("cursor").getInstances()[0];
        cursor.x = this.x - 9;
        return cursor.y = this.y - 9;
      };
      for (x = _i = 10; _i <= 728; x = _i += 80) {
        for (y = _j = 10; _j <= 550; y = _j += 80) {
          scene.createInstance(diamond, x, y);
        }
      }
      cursor.onStep = function() {
        return $("#debug").html("Mouse coords: " + this.scene.mouse_x + " / " + this.scene.mouse_y + "<br>Frameskip: " + this.engine.frameskip);
      };
      scene.createInstance(cursor, 0, 0);
      return engine.start();
    });
  });

}).call(this);