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
      var data = {};
      if($t.is('[data-method]')) data._method = $t.data('method');
      if($t.is('[data-form]')){
        $('input, select, textarea', $($t.data('form'))).each(function(){
          data[$(this).attr('name')] = $(this).val();
        });
      }
      if($t.is('[data-parent]')){
        $('input, select, textarea', $t.parents($t.data('parent')+':first')).each(function(){
          data[$(this).attr('name')] = $(this).val();
        });
      }
      $.extend(data, talebin.core.security);
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
    $('[data-uploader]').fileupload({
      dataType: 'json',
      formData: talebin.core.security,
      send: function(){
        talebin.core.loader.show();
      },
      done: function (e, data) {
        talebin.core.loader.hide();
        var $this = $(data.fileInput);
        eval($this.data('callback')).call($this, data.result);
      }
    });

    $('[data-remote]').bind('click', remote );
    $('[data-validate]').bind('click', talebin.core.validate );
    $('[data-updatable=remote]').on('click', '[data-remote]', remote );
    talebin.core.autoloadMessages();
    talebin.core.horoscopes();
  },
  horoscopes: function(){
    $('.fn-horoscopes .item:first').show();
    $('.fn-horoscopes').on( 'click', '.fn-sign-arrow', function(){
      var $t = $(this);
      var sign = $t.parents('.item:first');
      if($t.is('.next')){
        if(sign.next().size()==0){
          var next = $('.fn-horoscopes .item:first');
        }else{
          var next = sign.next();
        }
      }else{
        if(sign.prev().size()==0){
          var next = $('.fn-horoscopes .item:last');
        }else{
          var next = sign.prev();
        }
      }
      sign.fadeOut();
      next.fadeIn();
    })
  },
  loader: {
    show: function(){
      $('.fn-loading').fadeIn()
    },
    hide: function(){
      $('.fn-loading').fadeOut()
    }
  },
  validate: function(){
    var $t = $(this);
    var f = $t.parents($t.data('parent')+':first');
    var errors = [];
    $('input:not([type=radio],[type=checkbox])',f).each(
      function(){
        if($(this).val()=='')
          errors.push([$(this), 'null']);
      }
    );
    $('[type=radiogroup]',f).each(
      function(){
        if($('[type=radio]:checked', this).size()==0)
          errors.push([$(this), 'null']);
      }
    );
    if($t.is('[data-error-handler]'))
      eval($t.data('error-handler')).call($t, errors);
    if(errors.length>0) return false;
  },
  suggestions: function(data){
    var list = $('.fn-suggestions');
    $('.fn-suggestion:visible', list).remove();
    if(data==null) return $('.fn-no-more-suggestion').show();
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
  },
  avatar: function(d){
    $('.fn-avatar').attr('src',d.avatar);
  },
  logout: function(){
    location.href = '/';
  },
  profile: function(){
    location.href = '/home';
  },
  message: function(){
    $('#send-message').modal('hide').find('textarea').val('');
  },
  autoloadMessages: function(){
    var id = location.hash.slice(1);
    if(id=='') return;
    $('[href="/messages#'+id+'"]').click();
  },
  read: function(data){
    var item = $(this);
    $('.fn-message-list li').removeClass('selected');
    var row = item.parent();
    row.addClass('selected');
    $('.fn-chat-message:visible').remove();
    $('.fn-chat-message:hidden').template(data);
    $('.fn-send-message').show();
    $('.fn-conversation-intro').remove();
    if(data.length>=15)
      $('.fn-toolong').show();
    else
      $('.fn-toolong').hide();
    $('.fn-reply').data('remote', '/messages?user='+item.data('id'));
  },
  replied: function(data){
    $('.fn-send-message textarea').val('');
    $('.fn-chat-message:hidden').template(data);
  },
  tests: {
    failed: function(errors){
      $('.fn-survey-error').show();
    }
  }
}
talebin.core.init();

});
