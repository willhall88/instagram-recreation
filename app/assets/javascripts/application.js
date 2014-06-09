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

  channel3 = connection.subscribe('comments');
  channel3.bind('new', function(post) {
    console.log(post.user.username)
    var postElem = $('.post[data-id=' + post.comment.post_id + '] .comment-list')

    var template = $('#comments-template').html();
    var output = Mustache.render(template, post);

    postElem.append(output)
  });

  $('body').on('submit', '.new_comment', function(event){
    event.preventDefault();
    event.stopPropagation();

    $.post($(this).attr('action'), $(this).serialize(), function(response){})

  })

  $('body').on('click', '.like', function(event){
    event.preventDefault();
    event.stopPropagation();

    $.post($(this).attr('href'), $(this).serialize(), function(response){

      var targetId = response.post;
      var currentPost = $('.post[data-id=' + targetId + ']');

      var template = $('#likes-template').html();
      var output = Mustache.render(template, response);

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



  var latitude_data = 0;
  var longitude_data = 0;
  var map;

  GMaps.geolocate({
    success: function(position) {
      latitude_data = position.coords.latitude;
      longitude_data = position.coords.longitude;
      $('.longitude-field').val(position.coords.latitude);
      $('.latitude-field').val(position.coords.longitude);
      if(map){
        map.setCenter(latitude_data,longitude_data);
      }
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
  
  $("#new-post").on('shown.bs.modal', function() {
    if(!map){
      map = new GMaps({
        div: '#map',
        lat:latitude_data,
        lng:longitude_data,
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
    }
  });

   $('#submit-location-search').on('click', function(event){  
      event.preventDefault(); 
      event.stopPropagation();
      GMaps.geocode({
        address: $('#address').val(),
        callback: function(results, status) {
          if (status == 'OK') {
            var latlng = results[0].geometry.location;
            map.setCenter(latlng.lat(), latlng.lng());
            map.addMarker({
              lat: latlng.lat(),
              lng: latlng.lng()
            });
          }
          $('.longitude-field').val(latlng.lng());
          $('.latitude-field').val(latlng.lat());
        }
      });
    });

  // $('.edit-user').modal({
  //   remote: true;
  // });
});
