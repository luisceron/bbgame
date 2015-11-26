$(function() {
   initPage();
});

$(window).bind('page:change', function() {
  initPage();
})

function initPage() {
  $(document).ready(function(){
    $("#date").inputmask("d/m/y",{ "placeholder": "dd/mm/yyyy" });
  });
}