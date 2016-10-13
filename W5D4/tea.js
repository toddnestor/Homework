'use strict';
if(false) {
  const readline = require('readline');

  const reader = readline.createInterface({
    input: process.stdin,
    output: process.stdout
  });

  reader.question("Do you want some tea?", function(tea){
    reader.question("Do you want some biscuits?", function(biscuits){
      console.log(`You said ${tea} to tea, and ${biscuits} to biscuits.`);
      reader.close();
    });
  });
}

function Cat () {
    this.name = 'Markov';
    this.age = 3;
  }

  function Dog () {
    this.name = 'Noodles';
    this.age = 4;
  }

  Dog.prototype.chase = function (cat) {
    console.log(`My name is ${this.name} and I'm chasing ${cat.name}! Woof!`)
  };

  const Markov = new Cat ();
  const Noodles = new Dog ();

  Noodles.chase.apply(Markov, [Noodles]);
