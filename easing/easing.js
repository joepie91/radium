// Generated by CoffeeScript 1.7.1
(function() {
  $(function() {
    var engine, manager;
    manager = new ResourceManager("easing/assets");
    engine = new Engine(manager);
    window.debug_engine = engine;
    manager.addImages(["images/cursor.png"]);
    manager.prepare();
    return manager.preload(null, function() {
      var cursor, scene;
      engine.addCanvas($("#gamecanvas"));
      scene = engine.createScene("main");
      engine.createSprite("cursor", "images/cursor.png");
      cursor = engine.createObject("cursor");
      cursor.sprite = engine.getSprite("cursor");
      cursor.onClickGlobal = function(event) {
        this.x = this.engine.ease.quadInOut(this.x, event.x - 41, 35);
        return this.y = this.engine.ease.quadInOut(this.y, event.y - 41, 35);
      };
      cursor.onStep = function() {
        return true;
      };
      scene.createInstance(cursor, 0, 0);
      return engine.start();
    });
  });

}).call(this);