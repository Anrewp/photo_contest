function dropdownMenu() {
  document.getElementById("myDropdown").classList.toggle("show");
}

// Close the dropdown menu if the user clicks outside of it
window.onclick = function(event) {
  if (!event.target.matches('.dropbtn')) {
    var dropdowns = document.getElementsByClassName("dropdown-content");
    var i;
    for (i = 0; i < dropdowns.length; i++) {
      var openDropdown = dropdowns[i];
      if (openDropdown.classList.contains('show')) {
        openDropdown.classList.remove('show');
      }
    }
  }
}
$(document).on('ready turbolinks:load', function() {
  
// Shine effect on logo
$('#logo').hover(
  function(){$('#shine').css('display', 'block')}, 
  function(){$('#shine').css('display', 'none')}
);
$('#shine').hover(
  function(){$('#shine').css('display', 'block')}, 
  function(){$('#shine').css('display', 'none')}
);
});
// Show photo info
$(document).on({
    mouseenter: function(){
      $(this).parents(':eq(2)').find('.photo-info').css('display', 'block')
    },
    mouseleave: function(){
      $(this).parents(':eq(2)').find('.photo-info').css('display', 'none')
    }
  }, '.img-rounded');

$(document).on({
    mouseenter: function(){
      $(this).parents(':eq(1)').find('.img-rounded').toggleClass("hover");
      $(this).css('display', 'block');
    },
    mouseleave: function(){
      $(this).parents(':eq(1)').find('.img-rounded').toggleClass("hover");
    $(this).css('display', 'none')
    }
  }, '.photo-info');