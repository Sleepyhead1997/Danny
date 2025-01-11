import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/src/widgets/framework.dart';
// import 'package:flutter/src/widgets/placeholder.dart';
import 'package:geojson/geojson.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:projectmap/screens/detail.dart';
// import 'package:geopoint/geopoint.dart';

class Mymap extends StatefulWidget {
  const Mymap({super.key});

  static const String MAP_BOX_ACCESS_TOKEN =
      "sk.eyJ1IjoicHVuMnB1biIsImEiOiJjbGJ2bGN3a3gwMDB1M3Byd2E0NW91aGZ4In0.99j42_EqHa5hV913kt2syQ";

  @override
  State<Mymap> createState() => _MymapState();
}

class _MymapState extends State<Mymap> {
  late MapboxMapController mapController;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
  }

  Future<Map<String, dynamic>> fireStoreToGeoJson() async {
    final snapshot = await firestore.collection("location").get();
    final List features_1 = [];

    for (final data in snapshot.docs) {
      final latitude = double.parse(data['latitude']);
      final longitude = double.parse(data['longtitude']);

      features_1.add({
        "type": "Feature",
        "properties": {},
        "geometry": {
          "coordinates": [longitude, latitude],
          "type": "Point"
        }
      });
    }

    Map<String, dynamic> featureCollection = {
      "type": "FeatureCollection",
      "features": features_1
    };

    return await featureCollection;
  }

  void onMapCreate(MapboxMapController mapController) async {
    fireStoreToGeoJson().then((geoJson) async {
      print("GeoJson");
      print(geoJson);
      await mapController.addGeoJsonSource("dannayLocation-source", geoJson);

      await mapController.addCircleLayer(
          "dannayLocation-source",
          "dannayLocation-layer",
          const CircleLayerProperties(circleColor: '#4263f5'));
    });
  }

  void onMapLongClick(Point<double> point, LatLng coordinate) async {
    _showMyDialog(coordinate);
  }

  @override
  Widget build(BuildContext context) {
    return MapboxMap(
      initialCameraPosition:
          CameraPosition(target: LatLng(14.100, 100.10), zoom: 5),
      styleString:
          "https://api.maptiler.com/maps/hybrid/style.json?key=5Ie6f9KItqOgTZ7h9Yjw",
      onMapCreated: onMapCreate,
      onMapLongClick: onMapLongClick,
      compassEnabled: true,
    );
  }

  Future<void> _showMyDialog(LatLng coordinate) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Destination'),
          content: SingleChildScrollView(
              child: MyForm(
            coordinate: coordinate,
          )),
        );
      },
    );
  }
}
