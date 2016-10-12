function titleize(names, cb) {
  new_names = [];

  for(var i = 0; i < names.length; i++) {
    new_names.push(`Mx. ${names[i].charAt(0).toUpperCase() + names[i].slice(1)} Jingleheimer Schmidt`)
  }

  return cb(new_names);
}

titleize(["Mary", "Brian", "Leo"], function(names) {
  names.forEach(function(name){
    console.log(name);
  })
})

function Elephant(name, height, tricks) {
  this.name = name;
  this.height = height;
  this.tricks = tricks;
}

Elephant.prototype.trumpet = function() {
  console.log(`${this.name} goes phrrrrrr!!!!`);
}

Elephant.prototype.grow = function() {
  this.height += 12;
}

Elephant.prototype.addTrick = function(trick) {
  this.tricks.push(trick);
}

Elephant.prototype.play = function() {
  index = Math.round(Math.random() * (this.tricks.length - 1) )

  console.log(`${this.name} is ${this.tricks[index]}`);
}

var ellie = new Elephant("Ellie", 185, ["giving human friends a ride", "playing hide and seek"]);
var charlie = new Elephant("Charlie", 200, ["painting pictures", "spraying water for a slip and slide"]);
var kate = new Elephant("Kate", 234, ["writing letters", "stealing peanuts"]);
var micah = new Elephant("Micah", 143, ["trotting", "playing tic tac toe", "doing elephant ballet"]);

ellie.grow()
ellie.trumpet();
ellie.play();
ellie.play();

var herd = [ellie, charlie, kate, micah];

function elephantHelper(elephant) {
  console.log(`${elephant.name} is marching by!`)
}

herd.forEach(elephantHelper)
