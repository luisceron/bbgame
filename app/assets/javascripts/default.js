$(function() {
   initPage();
});

$(window).bind('page:change', function() {
  initPage();
})

$(document).on('ready page:load', function(){
  $("input").focus(function() {
    this.select();
  });

  $("#date").inputmask("d/m/y",{ "placeholder": "dd/mm/yyyy" });

});
