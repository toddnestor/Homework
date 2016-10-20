console.log("Hello from the JavaScript console!");

// Your AJAX request here
$.ajax({
  url: 'http://api.openweathermap.org/data/2.5/weather?q=NY,NY&appid=bcb83c4b54aee8418983c2aff3073b3b',
  method: 'GET',
  success: function(response) {
    console.log('here is the weather: ', response);
  }
})
// Add another console log here, outside your AJAX request
console.log("I get logged before the ajax response...even though I come after it!");
