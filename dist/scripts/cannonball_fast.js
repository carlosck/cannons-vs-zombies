// Generated by CoffeeScript 1.7.1
(function(root) {
  return root.cannonball_fast = function(_body, _cannon) {
    root.projectile.call(this, 50, _body, 59, _cannon);
    this.explode = function() {
      return this.body.parentNode.removeChild(this.body);
    };
  };
})(App);
