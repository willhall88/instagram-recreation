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
// require turbolinks
//= require bootstrap
//= require mustache
//= require websocket_rails/main
//= require gmaps
//= require_tree .

$(document).ready(function() {
  var connection = new WebSocketRails(window.location.host + '/websocket');
  channel1 = connection.subscribe('likes');
  channel1.bind('like', function(post) {
    var postElem = $('.post[data-id=' + post.id + '] .btn-like')
    postElem.text('❤ ' + post.new_like_count);
  });

  channel2 = connection.subscribe('unlikes');
  channel2.bind('unlike', function(post) {
    var postElem = $('.post[data-id=' + post.id + '] .btn-like')
    postElem.text('❤ ' + post.new_like_count);
  });


  $('body').on('click', '.like', function(event){
    event.preventDefault();
    event.stopPropagation();

    $.post($(this).attr('href'), $(this).serialize(), function(response){
 
      var targetId = response.post;
      var currentPost = $('.post[data-id=' + targetId + ']');

      var template = $('#likes-template').html();
      var output = Mustache.render(template, response)

      currentPost.find('.likes').prepend(output);
      currentPost.find('.like').replaceWith(response.unlike);
    }, 'json' );
  });

  $('body').on('click', '.unlike', function(event){  
    event.preventDefault();
    event.stopPropagation();
    $.post($(this).attr('href'), $(this).serialize(), function(response){

      var targetId = response.post;
      var currentPost = $('.post[data-id=' + targetId + ']');
      
      currentPost.find(".each-likes[data-id='" + response.user + "']").remove();
      currentPost.find('.unlike').replaceWith(response.like);
    }, 'json' );
  });


  $('body').on('click', '.post', function(){   
    
    GMaps.geolocate({
      success: function(position) {
        var latitude = position.coords.latitude;
        var longitude = position.coords.longitude;
        $('.longitude-field').val(longitude);
        $('.latitude-field').val(latitude);
        var map = new GMaps({
          div: '#map',
          lat: latitude,
          lng: longitude,
          click: function(event){
            map.removeMarkers();
            map.addMarker({
              lat: event.latLng.lat(),
              lng: event.latLng.lng()
            });
            $('.longitude-field').val(event.latLng.lng());
            $('.latitude-field').val(event.latLng.lat());
          }
        });   
      },
      error: function(error) {
        alert('Geolocation failed: '+error.message);
      },
      not_supported: function() {
        alert("Your browser does not support geolocation");
      },
      always: function() {
      }
    });
  });

    


  // $('.edit-user').modal({
  //   remote: true;
  // });
});
