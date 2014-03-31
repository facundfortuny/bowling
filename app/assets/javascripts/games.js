$().ready(function(){
  $('#ball1').bind('keyup', function(){
  if(strike() && $('#frame_number').val() != 10) {
      $('#block-ball2').hide()
    }
    else {
      $('#block-ball2').show()
    }
  })

  function strike() {
    return $('#ball1').val() == 10
  }
});