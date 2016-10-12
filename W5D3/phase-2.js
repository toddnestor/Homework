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
