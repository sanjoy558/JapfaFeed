/*
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:get/get.dart';
import 'package:japfa_feed_application/controllers/mapViewController.dart';

import 'package:latlong2/latlong.dart';

class MapViewScreen extends StatelessWidget {


  @override
  Widget build(BuildContext context) {

    final mapViewController = Get.put(MapViewController());
    return Scaffold(
      appBar: AppBar(
        title: Text('Map View'),
      ),
      body: FlutterMap(
        options: MapOptions(
          zoom: 12.0,
        ),
        layers: [
          TileLayerOptions(
            urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
            subdomains: ['a', 'b', 'c'],
          ),
          PolylineLayerOptions(
            polylines: [
              Polyline(
                points: mapViewController.getList(),
                color: Colors.blue,
                strokeWidth: 3.0,
              ),
            ],
          ),
          MarkerLayerOptions(
            markers: mapViewController.getList()
                .map((LatLng latLng) => Marker(
              width: 40.0,
              height: 40.0,
              point: latLng,
              builder: (ctx) => Container(
                child: Icon(
                  Icons.location_pin,
                  color: Colors.red,
                ),
              ),
            ))
                .toList(),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Total Distance: ${} km',
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
*/
