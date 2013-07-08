var talebin = {};

$(function(){

talebin.core = {
  security: { authenticity_token: $('[name=csrf-token]').attr('content') },
  init: function(){
    $('[data-callback]').bind('ajax:success', function(d) {
      console.log(this)
    });
    $('[data-remote]').bind('click', function() {
      var $t = $(this);
      if($t.data('busy')) return;
      $('i', $t).animate( { opacity: 0.1 } );
      var data = $.extend({}, talebin.core.security);
      var target = $($t.is('[data-target]')? $t.data('target') : $t);
      $t.data('busy', true);
      $.post( $t.data('remote'), data ).success( function(d){
        $t.data('busy', false);
        $('i', $t).animate( { opacity: 1 } );
        eval($t.data('callback')).call( target, d);
      });
    });
  },
  suggestions: function(data){
    var list = $('.fn-suggestions');
    $('.fn-suggestion:visible', list).remove();
    $('.fn-suggestion:hidden').template( data, { appendTo: list } );
  }
}
talebin.core.init();

});
