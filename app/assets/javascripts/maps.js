$(document).ready(function() {
  var postId = $('#map').data('post-id');

  $.get('/posts/' + postId + '.json', function(post){
    new GMaps({
      div: '#map',
      lat: -12.043333,
      lng: -77.028333
    });
  });

  GMaps.geocode({
  callback: function(results, status) {
    if (status == 'OK') {
      var latlng = results[0].geometry.location;
      map.setCenter(latlng.lat(), latlng.lng());
      map.addMarker({
        lat: latlng.lat(post.latitude),
        lng: latlng.lng(post.longitude)
      });
    }
  }
});

});
