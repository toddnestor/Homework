function madLib() {
  return `We shall ${arguments[0]} the ${arguments[1]} ${arguments[2]}.`
}

console.log(madLib('make','best','guac'));

function isSubstring(search, sub) {
  return search.indexOf(sub) > -1
}

console.log(isSubstring("time to program", "time"));

console.log(isSubstring("Jump for joy", "joys"));

function fizzBuzz(arr) {
  new_arr = []

  for(var i = 0; i < arr.length; i++) {
    if( arr[i] % 15 != 0 && (arr[i] % 5 == 0 || arr[i] % 3 == 0)) {
      new_arr.push(arr[i]);
    }
  }

  return new_arr;
}

console.log(fizzBuzz([3,5,15,30,25,22,23,21]));

function isPrime(n) {
  for(var i = 2; i <= Math.sqrt(n); i == 2 ? i++ : i = i + 2) {
    if(n % i == 0)
      return false
  }
  return true
}

console.log(isPrime(2));
console.log(isPrime(10));
console.log(isPrime(15485863));
console.log(isPrime(3548563));

function firstNPrimes(n) {
  primes = []
  possible_prime = 2;

  while(primes.length < n ) {
    if(isPrime(possible_prime))
      primes.push(possible_prime)

    possible_prime == 2 ? possible_prime++ : possible_prime = possible_prime + 2
  }

  return primes;
}

function sumNPrimes(n) {
  primes = firstNPrimes(n);

  sum = 0;

  for(var i = 0; i < primes.length; i++ )
    sum += primes[i];

  return sum;
}

console.log(sumNPrimes(0));
console.log(sumNPrimes(1));
console.log(sumNPrimes(4));

function allOrNothing() {
  mod = arguments[0];

  for(var i = 1; i < arguments.length; i++ ) {
    if(arguments[i] % mod != 0)
      return false;
  }

  return true;
}

console.log(allOrNothing(3, 9, 12, 6));
console.log(allOrNothing(5, 1, 2, 10));
