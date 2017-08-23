/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

/* global google, markers, latlngbounds */

var map;
var idInfoBoxAberto;
var infoBox = [];
var markers = [];

function initialize() {
    var latlng = new google.maps.LatLng(-18.8800397, -47.05878999999999);

    var options = {
        zoom: 5,
        center: latlng,
        mapTypeId: google.maps.MapTypeId.ROADMAP
    };

    map = new google.maps.Map(document.getElementById("mapa"), options);
}

function carregarPontos(pontos) {
         
    if (pontos === "") {
        getCurrentLocation();
    }
    
    var latlngbounds = new google.maps.LatLngBounds();

    $(pontos.results.bindings).each(function (index, ponto) {
        var marker = new google.maps.Marker({
            position: new google.maps.LatLng(ponto.lng.value, ponto.lat.value),
            title: ponto.nome.value,
            map: map,
            icon: ReturnIcoPoint(ponto)
            
        });

        //markers.push(marker);
        latlngbounds.extend(marker.position);
        //latlngbounds.extend(latLng);

        var myOptions = {
            content: layoutInfoBox(ponto),
            pixelOffset: new google.maps.Size(0, 0)
        };
        infoBox[index] = new google.maps.InfoWindow(myOptions);
        infoBox[index].marker = marker;
        infoBox[index].listener = google.maps.event.addListener(marker, 'click', function (e) {
            loadInforBox(index, marker)
        });
    });
    //var markerCluster = new MarkerClusterer(map, markers); 
    map.setCenter(latlngbounds.getCenter());
    map.fitBounds(latlngbounds);
  
}

function loadInforBox(id, marker) {
   
   
    if (typeof (idInfoBoxAberto) === 'number' && typeof (infoBox[idInfoBoxAberto]) === 'object') {
        infoBox[idInfoBoxAberto].close();
    }

    infoBox[id].open(map, marker);
    idInfoBoxAberto = id;
}

function ReturnIcoPoint(ponto) {

    if (ponto.rate1 !== undefined) {

        var p1 = ponto.rate1.value
        var p2 = ponto.rate2.value
        var p3 = ponto.rate3.value
        var p4 = ponto.rate4.value
        var result = parseInt((Number(p1) + Number(p2) + Number(p3) + Number(p4)) / 4)

        if (result == 1) {
            return "img/1.png";
        } else if (result == 2) {
            return "img/2.png";
        } else if (result == 3) {
            return "img/3.png";
        } else if (result == 4) {
            return "img/4.png";
        } else if (result == 5) {
            return "img/5.png";
        }
    } else {
         return "img/marcador2.png";
    }
        


}

function abrirInfoBox(id, marker) {

    

 
    if (typeof (idInfoBoxAberto) === 'number' && typeof (infoBox[idInfoBoxAberto]) === 'object') {
        infoBox[idInfoBoxAberto].close();
    }

    infoBox[id].open(map, marker);
    idInfoBoxAberto = id;

}

function  layoutInfoBox(ponto) {


    var contentString = '<div class="container">    ' +
            '            <div  ' +
            '                <div >  ' +
            '                    <div >  ' +
            '                        <h3>@nome</h3>  ' +
            '                    </div>  ' +
            '                    <div class="row">  ' +
            '                        <div >   ' +
            '                            <table class="table table-user-information">  ' +
            '                                <tbody>  ' +
            '                                    <tr>  ' +
            '                                        <td><span class="glyphicon glyphicon-earphone"></span> Telefone</td>  ' +
            '                                        <td>@telefone</td>  ' +
            '                                    </tr> ' +
            '                                    <tr>  ' +
            '                                        <td><span class="glyphicon glyphicon-time"></span> Horarios</td>  ' +
            '                                        <td>@horario</td>  ' +
            '                                    </tr> ' +
            '                                    <tr>  ' +
            '                                        <td><span class="glyphicon glyphicon-map-marker"></span> Endereço</td>  ' +
            '                                        <td>@endereco, @bairro , @cidade - @estado</td>  ' +
            '                                    </tr> ' +
            '                                    <tr>  ' +
            '                                        <td><span class="glyphicon glyphicon-info-sign"></span> Lista de Especialidades</td>  ' +
            '                                        <td>@especialidades</td>  ' +
            '                                    </tr>  ' +
            '                                    <tr>  ' +
            '                                        <td colspan="2"><span class="glyphicon glyphicon-thumbs-up"></span> Avaliação Governo</td>  ' +
            '                                    </tr>  ' +
            '                                    <tr> ' +
            '                                        <td colspan="2"> ' +
            '                                            <div class="container-fluid"> ' +
            '                                                <table style="width: 100%"> ' +
            '                                                    <tr><td><h5>Estrutura física:</h5></td><td>@rate1</td></tr> ' +
            '                                                    <tr><td><h5>Adap. p/ idosos:</h5></td><td>@rate2</td></tr> ' +
            '                                                    <tr><td><h5>Equipamentos:</h5></td><td>@rate3</td></tr> ' +
            '                                                    <tr><td><h5>Medicamentos</h5></td><td>@rate4</td></tr> ' +
            '                                                </table> ' +
            '                                            </div> ' +
            '                                        </td>  ' +
            '                                    </tr> ' +
            '                            </table>  ' +
            '                        </div>  ' +
            '                    </div>  ' +
            '                    <div style="text-align: right;display: none"><a data-original-title="Broadcast Message" data-toggle="tooltip" type="button" class="btn btn-sm btn-primary">Gravar</a></div>  ' +
            '                    <span class="pull-right">  ' +
            '                    </span>  ' +
            '                </div>  ' +
            '            </div>  ' +
            '        </div> ';
    
    
    contentString = contentString.replace("@nome", (ponto.nome.value == null ? "" : ponto.nome.value));
    contentString = contentString.replace("@telefone", (ponto.telefone.value == null ? "" : ponto.telefone.value));
    contentString = contentString.replace("@horario", (ponto.horario.value == null ? "" : ponto.horario.value));
    contentString = contentString.replace("@endereco", (ponto.endereco.value == null ? "" : ponto.endereco.value));
    contentString = contentString.replace("@bairro", (ponto.bairro.value == null ? "" : ponto.bairro.value));
    contentString = contentString.replace("@cidade", (ponto.cidade.value == null ? "" : ponto.cidade.value));
    contentString = contentString.replace("@estado", (ponto.estado.value == null ? "" : ponto.estado.value));
    contentString = contentString.replace("@especialidades", (ponto.especialidades.value == null ? "" : ponto.especialidades.value));

    if (ponto.rate1 !== undefined) {
        contentString = contentString.replace("@rate1", (ponto.rate1.value == null ? "" : ponto.rate1.value));
        contentString = contentString.replace("@rate2", (ponto.rate2.value == null ? "" : ponto.rate2.value));
        contentString = contentString.replace("@rate3", (ponto.rate3.value == null ? "" : ponto.rate3.value));
        contentString = contentString.replace("@rate4", (ponto.rate4.value == null ? "" : ponto.rate4.value));
    }
    
    return contentString;

}

function abrir() {
    var secheltLoc = new google.maps.LatLng(49.47216, -123.76307);
    var myMapOptions = {
        zoom: 15
        , center: secheltLoc
        , mapTypeId: google.maps.MapTypeId.ROADMAP
    };
    var map = new google.maps.Map(document.getElementById("mapa"), myMapOptions);
    var marker = new google.maps.Marker({
        map: map,
        draggable: true,
        position: new google.maps.LatLng(49.47216, -123.76307),
        visible: true
    });
    var boxText = document.createElement("div");
    boxText.style.cssText = "border: 1px solid black; margin-top: 8px; background: yellow; padding: 5px;";
    boxText.innerHTML = "City Hall, Sechelt<br>British Columbia<br>Canada";
    var myOptions = {
        content: boxText
        , disableAutoPan: false
        , maxWidth: 0
        , pixelOffset: new google.maps.Size(-140, 0)
        , zIndex: null
        , boxStyle: {
            background: "url('tipbox.gif') no-repeat"
            , opacity: 0.75
            , width: "280px"
        }
        , closeBoxMargin: "10px 2px 2px 2px"
        , closeBoxURL: "https://www.google.com/intl/en_us/mapfiles/close.gif"
        , infoBoxClearance: new google.maps.Size(1, 1)
        , isHidden: false
        , pane: "floatPane"
        , enableEventPropagation: false
    };
    google.maps.event.addListener(marker, "click", function (e) {
        ib.open(map, this);
    });
    var ib = new InfoBox(myOptions);
    ib.open(map, marker);
}

function getCurrentLocation() {
  if (navigator.geolocation) {
    navigator.geolocation.getCurrentPosition(showPosition);
  } else {
    alert("Geolocation is not supported by this browser.");
  }
}

function showPosition(position) {
  var lat = position.coords.latitude;
  var lng = position.coords.longitude;
  map.setCenter(new google.maps.LatLng(lat, lng));
}

