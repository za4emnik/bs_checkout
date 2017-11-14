function inc_dec(sign, el){
  var id = Number(el.id.match(/\d+/));
  var value = $('#order_items_'+id+'_quantity').val() * 1;

  if (sign == '+'){
    value += 1;
  }else{
    if(value >= 2){
      value -= 1;
    }
  }
  $('[data-quantity-item-id='+id+']').each(function() {
    $(this).val(value);
  });
}

$( document ).ready(hide_block($('#address_form_shipping_form_use_billing_address')[0]));

function hide_block(el){
  if (el.checked)
    $('#shipping_address_form').hide();
  else
    $('#shipping_address_form').show();
}
