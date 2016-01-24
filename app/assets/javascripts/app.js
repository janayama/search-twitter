$( document ).ready(function() {

    function loadMap(vizId) {
        map = L.map('map', { 
          zoomControl: true,
          center: [0, 0],
          zoom: 3
        });

        L.tileLayer('http://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png', {
            attribution: '&copy; <a href="http://www.openstreetmap.org/copyright">OpenStreetMap</a> contributors, &copy; <a href="http://cartodb.com/attributions">CartoDB</a>'
        })
        .addTo(map);

        cartodb.createLayer(map, 'https://janaya.cartodb.com/api/v2/viz/ ' + vizId + '/viz.json', { https: true })
        .addTo(map)
        .on('done', function(layer) {
            var sublayer = layer.getSubLayer(0);
            cdb.vis.Vis.addInfowindow(map, layer.getSubLayer(0), ['name', 'text']);
        }).on('error', function() {
            console.log("some error occurred");
        });
    }

    function loading(show) {
        if (show) {
            $('#loading, #loader-gif').show();
            $('#tip').hide();
        } else {
            $('#loading, #loader-gif').hide();
            $('#tip').show();
        }
    }

    function emptyMap() {
        if (map)
            map.remove();
        $('#map').html('');
        $('#map')[0].className = $('#map')[0].className.replace(/\bleaflet.*?\b/g, '');
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
