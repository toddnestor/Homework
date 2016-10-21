//curry practice

Function.prototype.curry = function(n) {
  let args = [];
  let that = this;

  return function _curry(arg) {
    args.push(arg);

    if( args.length === n ) {
      let result = that.apply(null, args);
      args = [];
      return result;
    } else {
      return _curry;
    }
  }
}


function sum(...numbers) {
  return numbers.reduce((accumulator, n) => accumulator + n);
}

//merge sort

function mergeArrays(arr1, arr2) {
  if( arr1.length < 1 || arr2.length < 1 ) {
    return arr1.concat(arr2);
  }

  let first = null;

  if( arr1[0] < arr2[0]) {
    first = arr1[0];
    arr1 = arr1.slice(1);
  } else {
    first = arr2[0];
    arr2 = arr2.slice(1);
  }

  return [first].concat(mergeArrays(arr1, arr2));
}

Array.prototype.mergeSort = function() {
  if(this.length < 2) {
    return this;
  }

  let half = Math.round(this.length / 2);
  let left = this.slice(0, half);
  let right = this.slice(half);

  return mergeArrays(left.mergeSort(), right.mergeSort());
}

Array.prototype.bSearch = function(target) {
  if(this.length === 0 ) {
    return -1;
  }

  let pivot = Math.floor(this.length / 2);

  if( this[pivot] === target ) {
    return pivot;
  } else if (target < this[pivot]) {
    return this.slice(0, pivot).bSearch(target);
  } else {
    let search = this.slice(pivot + 1).bSearch(target);
    if(search === -1 ) {
      return search
    } else {
      return search + pivot + 1;
    }
  }
}

Array.prototype.pairSum = function(target) {
  let pairs = [];

  for(let i = 0; i < this.length; i++) {
    for(let j = i + 1; j < this.length; j++) {
      if( this[i] + this[j] === target ) {
        pairs.push([i, j]);
      }
    }
  }

  return pairs;
}

Array.prototype.myInject = function(cb) {
  if( this.length === 0 ) {
    return null;
  }

  let accumulator = this[0];
  for(let i = 1; i < this.length; i++ ) {
    accumulator = cb(accumulator, this[i]);
  }

  return accumulator;
}

Array.prototype.subsets = function() {
  if( this.length < 1 ) {
    return [[]];
  }

  let subsets = this.slice(1).subsets();

  return subsets.concat( subsets.map( sub => sub.concat([this[0]])));
}
