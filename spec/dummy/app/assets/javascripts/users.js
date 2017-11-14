$(document).on("click", ".general-settings-checkbox", function(){
  var input = $('#delete-account-button');

  if ($('#understand-button').is(":checked")){
   input.prop('disabled', false);
   input.removeClass('disabled');
   input.addClass('btn-default');
  }else{
   input.prop('disabled', true);
   input.removeClass('btn-default');
   input.addClass('disabled');
  }
});
