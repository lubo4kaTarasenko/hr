$( document ).ready(function() {
  $('#need').click(function(){
    $('.eq_form').removeClass('hidden')
    $('#need').addClass('hidden')
  })

  $('#vacation').click(function(){
    $('.vac_form').removeClass('hidden')
    $('#vacation').addClass('hidden')
  })

  $('#sick').click(function(){
    $('.sick_form').removeClass('hidden')
    $('#sick').addClass('hidden')
  }) 

  $('#export').click(function(){
    $('.export_form').removeClass('hidden')
    $('#export').addClass('hidden')
  })
});
