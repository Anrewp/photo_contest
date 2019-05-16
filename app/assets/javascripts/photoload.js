function readURL(input) {
        if (input.files && input.files[0]) {
          var reader = new FileReader();

          reader.onload = function (e) {
            $('#img_prev')
              .attr('src', e.target.result)
              .width(100)
              .height(100);
          };

          reader.readAsDataURL(input.files[0]);
        }
      }

  
 $(document).on('ready turbolinks:load', function() { 
  $('#photo_picture').bind('change', function() {
    if(this.files[0] != undefined){
    var size_in_megabytes = this.files[0].size/1024/1024;
    if (size_in_megabytes > 5) {
      alert('Maximum file size is 5MB. Please choose a smaller file.');
      $('#submitBtn').css("display","none");
      $('#photo_name').css("display","none");
      $('#photo-label').css("display","none");
    }
     if (this.files[0] === undefined || size_in_megabytes > 5){
      $('#submitBtn').css("display","none");
      $('#img_prev').css("display","none");
       $('#uploadFileName').html('');
       $('#photo_name').css("display","none");
       $('#photo-label').css("display","none");
     }
     else{  $('#submitBtn').css("display","block");
             $('#img_prev').css("display","block");
             $('#uploadFileName').html(this.files[0].name);
             $('#photo_name').css("display","block");
             $('#photo-label').css("display","block");
           }
   }else {
    $('#submitBtn').css("display","none");
    $('#img_prev').css("display","none");
    $('#uploadFileName').html('');
    $('#photo_name').css("display","none");
    $('#photo-label').css("display","none");
  }
  });
  });