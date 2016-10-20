document.addEventListener("DOMContentLoaded", () => {
  // toggling restaurants

  const toggleLi = (e) => {
    const li = e.target;
    if (li.className === "visited") {
      li.className = "";
    } else {
      li.className = "visited";
    }
  };

  document.querySelector("#restaurants").addEventListener('click', e => {
    if( e.target.localName === 'li' ) {
      toggleLi(e);
    }
  });



  // adding SF places as list items
  const addFavoritePlace = () => {
    let newRestaurant = document.querySelector('.favorite-input').value;
    document.querySelector('.favorite-input').value = '';
    let li = document.createElement('li');
    li.innerHTML = newRestaurant;
    document.getElementById('restaurants').appendChild(li);
  }

  document.querySelector('.photo-show-button').addEventListener('click', e => {
    e.preventDefault();

    let addPhotoForm = document.querySelector('.photo-form-container');

    if(addPhotoForm.className === 'photo-form-container hidden') {
      addPhotoForm.className = 'photo-form-container';
    } else {
      addPhotoForm.className = 'photo-form-container hidden';
    }
  })

  document.querySelector('.favorite-submit').addEventListener('click', e => {
    e.preventDefault();
    addFavoritePlace();
  });


  // --- your code here!



  // adding new photos

  // --- your code here!
  const addNewPhoto = () => {
    let newPhoto = document.querySelector('.photo-url-input').value;
    document.querySelector('.photo-url-input').value = '';

    let img = document.createElement('img');
    img.src = newPhoto;
    document.querySelector('.dog-photos').appendChild(img);
  }

  document.querySelector('.photo-url-submit').addEventListener('click', e => {
    e.preventDefault();

    addNewPhoto();
  })
});
