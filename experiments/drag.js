(function () {$(function() {
  var engine, manager;
  manager = new ResourceManager("assets");
  engine = new Engine(manager);
  window.debug_engine = engine;
  manager.addImages(["ball.png"]);
  return manager.prepare(function() {
    engine.addCanvas($("#gamecanvas"));
    engine.setInitialScene(engine.createScene("main"));
    return manager.load(function() {
      var ball;
      engine.createSprites({
        "ball": "ball.png"
      });
      ball = engine.createObject("ball");
      ball.sprite = engine.getSprite("ball");
      ball.onStep = function() {
        return true;
      };
      engine.getScene("main").onLoad = function() {
        return this.createInstance(ball, 0, 0);
      };
      return engine.start();
    });
  });
});
})();