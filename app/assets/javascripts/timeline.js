// いいねユーザダイアログ
$(function () {
  $('#likedUserDialog').on('show.bs.modal', function (event) {
    var post_id = $(event.relatedTarget).val();
    $('#likedUsersForm [name=id]').val(post_id);
    $('#likedUsersForm [name=commit]').click();
  });
});

// 自動スクロール
$(window).on('scroll', function() {
  scrollHeight = $(document).height();
  scrollPosition = $(window).height() + $(window).scrollTop();
  if ( (scrollHeight - scrollPosition) / scrollHeight <= 0.05) {
    $('.jscroll').jscroll({
      contentSelector: '.scroll-list',
      nextSelector: 'span.next:last a'
    });
  }
});
