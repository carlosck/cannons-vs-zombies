// Generated by CoffeeScript 1.7.1
(function(root) {
  return root.neighbor = function(_hp, _body, _velocity, _points) {
    root.human.call(this, _hp, _body, _velocity, _points);
    this._points = _points;
    this.xrand = 0;
    this.yrand = 0;
    this.update = function() {
      var that;
      that = this;
      if (this.status === "alive") {
        if (this.xrand < this.left) {
          this.left -= this.velocity;
        } else {
          this.left += this.velocity;
        }
        if (this.yrand < this.top) {
          return this.top -= this.velocity;
        } else {
          return this.top += this.velocity;
        }
      }
    };
    this.new_path = function() {
      this.xrand = Math.floor(Math.random() * 700) + 100;
      return this.yrand = Math.floor(Math.random() * 500);
    };
    this.start_walking = function() {
      this.status = "alive";
      App.new_path();
      this.left = Math.floor(Math.random() * 700) + 100;
      this.top = Math.floor(Math.random() * 500);
      root.find(this.body, ".healt_bar").innerHTML = this.hp;
      root.css(this.body, {
        "left": this.left + "px"
      });
      root.css(this.body, {
        "top": this.top + "px"
      });
      return this.is_walking = true;
    };
  };
})(App);
