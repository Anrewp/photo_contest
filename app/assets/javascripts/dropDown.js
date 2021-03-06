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
// Show photo info on user profile photo
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

//Photo Show Reply form on click
function showForm(linkId){
  var formId = "#new_comment" + linkId;
  if($(formId).css("display") === "none"){

  $(formId).css('display','block')
  }
  else { $(formId).css('display','none'); }
};

$(document).on('ready turbolinks:load', function() {
$('.gallery').css('display','flex').hide().slideDown(550)
// $('.reverse').css('display','block').hide().slideDown(1100)
});

//Reverse button function
function reverseLeaders(){
  
  var valueCheck =  $('#reverse-value').val();
 if(valueCheck === "true"){
   $('#reverse-value').val(false);
   $('.reverse').css("background-color","#fff");
 }
 else {
  $('#reverse-value').val(true);
   $('.reverse').css("background-color","#FF4747");
 }
};

$(document).on('change','#search', function() {
  $('#page').val('1');
});

$(document).on('click','.page a', function(e) {
var currentPage = +($(this).text());
if(currentPage === 0){ currentPage = 1 };
$('#page').val(currentPage.toString());
});