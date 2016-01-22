$( document ).ready(function() {

    function loadMap(vizId) {
        cartodb.createVis('map', 'https://janaya.cartodb.com/api/v2/viz/' + vizId + '/viz.json', {
            search: true,
            tiles_loader: true,
            center_lat: 0,
            center_lon: 0,
            zoom: 2
        })
        .done(function(vis, layers) {
          layers[1].setInteraction(true);
          layers[1].on('featureOver', function(e, latlng, pos, data) {
            cartodb.log.log(e, latlng, pos, data);
          });

          var map = vis.getNativeMap();

        })
        .error(function(err) {
          console.log(err);
        });
    }

    function loading(show) {
        if (show) {
            $('#loading, #loader-gif').show();
            $('#tip, #map').hide();
        } else {
            $('#loading, #loader-gif').hide();
            $('#tip, #map').show();
        }
    }

    function emptyMap() {
        $('#map').html('');
    }

    $('form').submit(function(e){
        e.preventDefault();
        emptyMap();

        var category = $('#category').val();
        if (!category) {
            $('#category').focus();
            return;
        }

        loading(true);

        $.ajax({
            url: '/search/tweets',
            dataType: 'json',
            data: { 
                'category': $('#category').val()
            },
            method: 'POST',
            cache: false,
            context: this,
            success: function(data) {
                loadMap(data.visualization_id);
                loading(false);
            },
            error: function () {
                console.log('error');
            }
        });
    });
});
