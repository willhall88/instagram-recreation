// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require bootstrap
//= require mustache

$(document).ready(function() {
  
  $('.like').click(function(){
    $.post($(this).attr('href'), $(this).serialize(), function(response){
      console.log(response.unlike)

      var targetId = response.post;
      var currentPost = $('.post[data-id=' + targetId + ']');
      
      currentPost.find('.likes').prepend(response.user + ", ");
      currentPost.find('.like').replaceWith(response.unlike);
    }, 'json' );
    return false;
  });



  // $('.edit-user').modal({
  //   remote: true;
  // });
});