    function initialize() {
        var latlng = new google.maps.LatLng(43.62737, -79.62701);
        var settings = {
            zoom: 15,
            center: latlng,
            mapTypeControl: true,
            mapTypeControlOptions: {style: google.maps.MapTypeControlStyle.DROPDOWN_MENU},
            navigationControl: true,
            navigationControlOptions: {style: google.maps.NavigationControlStyle.SMALL},
            mapTypeId: google.maps.MapTypeId.ROADMAP
    };
  
  var map = new google.maps.Map(document.getElementById("map_canvas"), settings);
  
 var companyLogo = new google.maps.MarkerImage('images/s89map.png',
	new google.maps.Size(100,50),
	new google.maps.Point(0,0),
	new google.maps.Point(50,50)
);
var companyShadow = new google.maps.MarkerImage('images/s89map_shadow.png',
	new google.maps.Size(130,50),
	new google.maps.Point(0,0),
	new google.maps.Point(65, 50)
);
var companyPos = new google.maps.LatLng(43.62737, -79.62701);
var companyMarker = new google.maps.Marker({
	position: companyPos,
	map: map,
	icon: companyLogo,
	shadow: companyShadow,
	title:"Studio 89"
});
  }
  