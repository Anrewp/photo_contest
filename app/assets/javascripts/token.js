function getUserToken() {
        $.ajax({
            url: '/api/v1/users/user_token',
            method: 'GET',
            dataType: 'json',
            beforeSend: function(xhr) {xhr.setRequestHeader('X-CSRF-Token', $('meta[name="csrf-token"]').attr('content'))},
            complete: function(data) {
                
               $('#credentials-token').html('<strong>Token:</strong>' + data.responseText) ;
               $("#token").fadeOut(500);
               setTimeout(function() {
                $('#token-li').css('display','none'); 
                $('#credentials-token').css('display','block').fadeOut();
                $('#credentials-token').fadeIn(300);
               }, 500);

            }
        });
};

$(document).on('mouseenter','#token', function() {
    var p = document.getElementById('p');
    $('#p').fadeOut(150);
    setTimeout(function() { p.textContent = 'show token'; }, 200);
    $('#p').fadeIn(150);
});
$(document).on('mouseleave','#token, li, ul', function() {
    var p = document.getElementById('p');
    p.textContent = 'T';
});