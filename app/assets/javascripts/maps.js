$(document).ready(function() {
  var postId = $('#map').data('post-id');

  if (postId) {
    $.get('/posts/' + postId + '.json', function(post){
      map = new GMaps({
        div: '#map',
        lat: post.latitude,
        lng: post.longitude,
      });

    map.addMarker({
        lat: post.latitude,
        lng: post.longitude
      });
    });
  }
});
