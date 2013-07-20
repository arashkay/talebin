var talebin = {};

$(function(){

talebin.core = {
  security: { authenticity_token: $('[name=csrf-token]').attr('content') },
  init: function(){
    $('[data-callback]').bind('ajax:success', function(d) {
      console.log(this)
    });
    var remote = function() {
      var $t = $(this);
      if($t.data('busy')) return;
      $('i', $t).animate( { opacity: 0.1 } );
      var data = $.extend({}, talebin.core.security);
      var target = $($t.is('[data-target]')? $t.data('target') : $t);
      $t.data('busy', true);
      talebin.core.loader.show();
      $.post( $t.data('remote'), data ).success( function(d){
        $t.data('busy', false);
        $('i', $t).animate( { opacity: 1 } );
        talebin.core.loader.hide();
        eval($t.data('callback')).call( target, d);
      });
    };
    $('[data-remote]').bind('click', remote );
    $('[data-updatable=remote]').on('click', '[data-remote]', remote );
  },
  loader: {
    show: function(){
      $('.fn-loading').fadeIn()
    },
    hide: function(){
      $('.fn-loading').fadeOut()
    }
  },
  suggestions: function(data){
    var list = $('.fn-suggestions');
    $('.fn-suggestion:visible', list).remove();
    $('.fn-suggestion:hidden').template( data, { appendTo: list } );
  },
  point: function(){
    $(this).parents('.fn-suggestion').remove();
  },
  respond: function(d){
    if(d==false) return;
    var row = $(this).parents('.fn-row');
    var src = $('img', row).attr('src');
    var link = $('a:first', row).attr('href');
    var name = $('span', row).text();
    ((d=='reject')
      ? $('.fn-reject:first')
      : $('.fn-accept:first')).find('img').attr('src', src).end().find('span').text(name).end().find('a').attr('href', link).end().insertBefore(row);
    row.remove();
  },
  invite: function(){
    $(this).remove();
  }
}
talebin.core.init();

});