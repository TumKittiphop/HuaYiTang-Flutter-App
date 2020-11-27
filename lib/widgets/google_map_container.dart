import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      margin: EdgeInsets.symmetric(horizontal: 15),
      child: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          GoogleMapController _controller = controller;
          Future.delayed(const Duration(seconds: 2), () {
            _controller.showMarkerInfoWindow(MarkerId('HuaYiTang'));
            _controller.animateCamera(
              CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: LatLng(
                    13.7123779,
                    100.5255135,
                  ),
                  zoom: 16,
                ),
              ),
            );
          });
        },
        initialCameraPosition: CameraPosition(
          target: LatLng(
            13.7123779,
            100.5255135,
          ),
          zoom: 12,
        ),
        scrollGesturesEnabled: true,
        zoomGesturesEnabled: true,
        //myLocationButtonEnabled: true,
        gestureRecognizers: <Factory<OneSequenceGestureRecognizer>>[
          new Factory<OneSequenceGestureRecognizer>(
            () => new EagerGestureRecognizer(),
          ),
        ].toSet(),
        minMaxZoomPreference: MinMaxZoomPreference(10, 20),
        markers: <Marker>[
          Marker(
            markerId: MarkerId('HuaYiTang'),
            position: LatLng(
              13.7123779,
              100.5255135,
            ),
            infoWindow: InfoWindow(
              // anchor: Offset(10,10),
              title: "ฮัวอุยตึ๊ง",
              snippet: 'คลินิกการแพทย์แผนจีน',
            ),
          ),
        ].toSet(),
      ),
    );
  }
}
