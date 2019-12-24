// いいねユーザダイアログ
$(function () {
  $('#likedUserDialog').on('show.bs.modal', function (event) {
    var post_id = $(event.relatedTarget).val();
    $('#likedUsersForm [name=id]').val(post_id);
    $('#likedUsersForm [name=commit]').click();
  });
});
