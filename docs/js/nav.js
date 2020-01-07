let topNav = document.getElementById('topNav');
let navBarToggle = document.getElementById('js-navbar-toggle');

navBarToggle.addEventListener('click', function () {
  
  topNav.classList.toggle('active');
});