'use strict';


function hammerTime(time) {
  setTimeout(function(){
    alert(`${time} is HAMMERTIME!!!`);
  }, time);
}

hammerTime(1000);
