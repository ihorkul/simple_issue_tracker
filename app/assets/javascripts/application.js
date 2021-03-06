// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require turbolinks
//= require_tree .
//= require jquery
//= require jquery_ujs
//= require jquery-ui/widgets/sortable
//= require bootstrap-sprockets
//= require select2.full

function sortable_tickets(){
$( ".column_content" ).sortable({
    connectWith: ".column_content",
    cursor: 'move',
    placeholder: "portlet-placeholder ui-corner-all",
    receive: update_status
  });
 
  $( ".portlet" )
    .addClass( "ui-widget ui-widget-content ui-helper-clearfix ui-corner-all" )
    .find( ".portlet-header" ).addClass( "ui-widget-header ui-corner-all" )

  function update_status(event, ui) {
    var status_id = $(this).siblings('.column_header').data('status-id');
    var issue_id = ui.item.data('issue-id');
    var data = { issue: { status_id: status_id } }
    send_ajax(issue_id, data)
  }
}

$(document).on('click', '.btn.assign', function(){
  var issue_id = $(this).parents('.container').data('issue-id');
  var user_id = $(this).data('user-id');
  var data = { issue: { user_id: user_id } }
  send_ajax(issue_id, data)
})

$(document).on('change', '.update_status', function(){
  var issue_id = $(this).parents('.container').data('issue-id');
  var status_id = $(this).val();
  var data = { issue: { status_id: status_id } }
  send_ajax(issue_id, data)
})
function send_ajax(issue_id, data){
  $.ajax({
    type: 'PUT',
    dataType : 'script',
    data: data,
    url: '/issues/' + issue_id
  });
}
