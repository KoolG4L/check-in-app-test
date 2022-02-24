import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CheckMapsHistory extends StatelessWidget {
  final double longitude;
  final double latitude;
  final bool isCheckIn;
  CheckMapsHistory(
      {Key? key,
      required this.longitude,
      required this.latitude,
      required this.isCheckIn})
      : super(key: key);

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var latLng = LatLng(latitude, longitude);
    final _currentPosition = CameraPosition(target: latLng, zoom: 20);

    final _currentMarker = Marker(
        markerId: const MarkerId("_historyMarker"),
        icon: BitmapDescriptor.defaultMarker,
        position: latLng);

    final _currentCircle = Circle(
        circleId: const CircleId("_historyCircle"),
        fillColor: Colors.lightBlue.withOpacity(0.2),
        strokeColor: Colors.transparent,
        center: latLng,
        radius: 25);

    return Scaffold(
      body: Stack(
        alignment: Alignment.topCenter,
        children: [
          GoogleMap(
            markers: {_currentMarker},
            circles: {_currentCircle},
            mapType: MapType.normal,
            initialCameraPosition: _currentPosition,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
          Positioned(
            top: 52.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              child: Text(
                "Lokasi ${isCheckIn ? "Check In" : "Check Out"}",
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: const [
                  BoxShadow(
                      color: Color.fromRGBO(0, 0, 0, .25), blurRadius: 16.0)
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
