// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults
$(function() {
  if ($("#ticket_table_bg").length > 0) {
    setTimeout(updateComments, 10000);
  }
  $('.submit_comment').click(function() {
    $(this).closest('tr').hide();
    $(this).closest('tr').prev('tr').show();
    updateCommentsAfterSubmit();
  });
});

function updateComments() {
  var ticket_id = $("#ticket_table_bg").attr("data-id");
  if ($("#ticket_comment").length > 0) {
    var after = $("#ticket_comment:first-child").attr("data-time");
  } else {
    var after = "0";
  }
  $.getScript("/comments.js?ticket_id="+ticket_id+"&after="+after);
  setTimeout(updateComments, 10000);
}

function updateCommentsAfterSubmit() {
  var ticket_id = $("#ticket_table_bg").attr("data-id");
  if ($("#ticket_comment").length > 0) {
    var after = $("#ticket_comment:first-child").attr("data-time");
  } else {
    var after = "0";
  }
  $.getScript("/comments.js?ticket_id="+ticket_id+"&after="+after);
}

