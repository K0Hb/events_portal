ymaps.ready(init);
let myMap;

function init(){
  let address = document.getElementById('map').getAttribute('data-address');

  let myMap = new ymaps.Map("map", {
    center: [59.94, 30.31],
    zoom: 10
  });

  let myGeocoder = ymaps.geocode(address);

  myGeocoder.then(
    function (res) {
      let coordinates = res.geoObjects.get(0).geometry.getCoordinates();

      myMap.geoObjects.add(
        new ymaps.Placemark(
          coordinates,
          {iconContent: address},
          {preset: 'islands#blueStretchyIcon'}
        )
      );

      myMap.setCenter(coordinates);
      myMap.setZoom(15);
    }, function (err) {
      alert('Ошибка при определении местоположения');
    }
  );
}
