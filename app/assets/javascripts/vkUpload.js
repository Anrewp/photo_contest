function VkUpload() {
  var baseDom = 'https://api.vk.com'
  var apiV = '&v=5.101'
  var apiMethod = '/method/photos.getAll?'
  var uid = "uid=" + getCookie('uid')
  var access_token = 'access_token=' + getCookie('access_token')

        $.ajax({
            url: baseDom + apiMethod + uid + '&' + access_token + apiV,
            method: 'GET',
            dataType: 'jsonp',
            jsonpCallback: "photos"
        });
};

function photos(json){
  $("#vk").hide()
  $(".vk-form").show()
  if (json.error){ alert(json.error.error_msg) }
  else{
    let i = 0;
    var intervalId =  setInterval(function() {  
      if (i > 4){ clearInterval(intervalId) }
      if(json.response.items[i]){
        var lastElement = json.response.items[i].sizes.length - 1
        $("#vk-img" + i).attr("src",json.response.items[i].sizes[lastElement].url).fadeIn(2000);
        $("#picture_url_name" + i).attr('value', json.response.items[i].id)
        $("#picture_url" + i).attr('value', json.response.items[i].sizes[lastElement].url)
        $("#upload" + i).fadeIn(2000)
      }
      i++;
    }, 500);
  }
}
  function getCookie(name) {
  let matches = document.cookie.match(new RegExp(
    "(?:^|; )" + name.replace(/([\.$?*|{}\(\)\[\]\\\/\+^])/g, '\\$1') + "=([^;]*)"
  ));
  return matches ? decodeURIComponent(matches[1]) : undefined;
}

function hideBtn(e){
  $(e).fadeOut(600)
  $(e).parents(':eq(1)').find('img').fadeOut(600)
}