!function(t){return t.zombie_heavy=function(i,s){t.human.call(this,350,i,2,200),this.cannon=s,this.update=function(){var t;return t=this,(this.status="alive")?this.left-=this.velocity:void 0},this.start_walking=function(){return t.find(this.body,".healt_bar").innerHTML=this.hp,this.left=700,t.css(this.body,{left:this.left+"px"}),t.css(this.body,{top:100*this.cannon+"px"}),t.add_class(this.body,"alive"),this.is_walking=!0}}}(App);
//# sourceMappingURL=./zombie_heavy.map