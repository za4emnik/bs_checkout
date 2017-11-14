$('.inc').bind('click', function(){
  inc_dec('+');
});
$('.dec').bind('click', function(){
  inc_dec('-');
});

function inc_dec(sign){
  var value = $('#quantity').val() * 1;

  if (sign == '+'){
    value += 1;
  }else{
    if(value >= 2){
      value -= 1;
    }
  }
  $('#quantity').val(value);
}
