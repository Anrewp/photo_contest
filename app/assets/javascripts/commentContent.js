$(document).on('click', '#submit-comment' , function(e) {
        var textareaContent = this.form[4].value;
        if(textareaContent) {}
        else{
            alert("Content can't be blank");
            e.preventDefault();
        }
});