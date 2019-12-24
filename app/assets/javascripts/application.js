//= require jquery.jscroll.min.js
//= require toastr

// 投稿ダイアログ
$(function () {
  $('#postDialog').on('hide.bs.modal', function (event) {
    $('#post_content').val('');
    $('#post_picture').val('');
  });
});