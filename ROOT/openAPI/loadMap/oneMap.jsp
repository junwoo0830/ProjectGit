<!DOCTYPE html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
<%@ page contentType="text/html; charset=utf-8" %>
<%@ page import="java.sql.*,javax.sql.*,java.io.*,java.util.*,java.text.*" %>
<html>
  <head>
    <meta name="viewport" content="initial-scale=1.0, user-scalable=no">
    <meta charset="utf-8">
    <title>Marker Clustering</title>
    <style>
      /* Always set the map height explicitly to define the size of the div
       * element that contains the map. */
      #map {
        height: 100%;
      }
      /* Optional: Makes the sample page fill the window. */
      html, body {
        height: 100%;
        margin: 0;
        padding: 0;
      }
    </style>
	
  <%
	String coordx=request.getParameter("coordx");
	String coordy=request.getParameter("coordy");
	String eventstatusmsg = request.getParameter("eventstatusmsg");
	eventstatusmsg=new String(eventstatusmsg.getBytes("8859_1"),"utf-8");
  %>
  </head>
  <body>
  <center>
	<br><br>
    <div id="map" style="width:500px; height:500px;"></div>
    <script>

      function initMap() {

        var map = new google.maps.Map(document.getElementById('map'), {
          zoom: 14,
          center: {lat: <%=coordy%>, lng: <%=coordx%>}
        });

        // Create an array of alphabetical characters used to label the markers.
        var labels = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';

        // Add some markers to the map.
        // Note: The code uses the JavaScript Array.prototype.map() method to
        // create an array of markers based on a given "locations" array.
        // The map() method here has nothing to do with the Google Maps API.
        var markers = locations.map(function(location, i) {
          return new google.maps.Marker({
            position: location,
            label: labels[i % labels.length]
          });
        });

        // Add a marker clusterer to manage the markers.
        var markerCluster = new MarkerClusterer(map, markers,
            {imagePath: 'https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/m'});
      }
      var locations = [ //lan cordy
        {lat: <%=coordy%>, lng: <%=coordx%>}      
      ]
    </script>
    <script src="https://developers.google.com/maps/documentation/javascript/examples/markerclusterer/markerclusterer.js">
    </script>
    <script async defer
    src="https://maps.googleapis.com/maps/api/js?key=AIzaSyCx2z0IiB4BoaW9r5XQuPEexSjtZlAoLW0&callback=initMap">
    </script>
	<h3><p><%=eventstatusmsg%></p></h3>
	<input type="button" value="뒤로가기" onclick="history.back()">
	<center>
  </body>
</html>