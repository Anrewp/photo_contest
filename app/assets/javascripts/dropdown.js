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
// Show photo info
$('.img-rounded').hover(
  function(){$(this).parents(':eq(2)').find('.photo-info').css('display', 'block')}, 
  function(){$(this).parents(':eq(2)').find('.photo-info').css('display', 'none')}
);

$('.photo-info').hover(
  function(){
    $(this).parents(':eq(1)').find('.img-rounded').toggleClass("hover");
    $(this).css('display', 'block');
  }, 
  function(){

    // $(this).parents(':eq(1)').find('.img-rounded').trigger(e.type)
    $(this).parents(':eq(1)').find('.img-rounded').toggleClass("hover");
    $(this).css('display', 'none')
  }

);
});