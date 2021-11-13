import 'package:churchapp_flutter/models/Branches.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/TextStyles.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class LocationMap extends StatefulWidget {
  static const routeName = "/LocationMap";
  const LocationMap({Key key, this.branches}) : super(key: key);
  final Branches branches;

  @override
  _LocationMapState createState() => _LocationMapState();
}

class _LocationMapState extends State<LocationMap> {
  Completer<GoogleMapController> _controller = Completer();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("View in Map"),
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: GoogleMap(
          mapType: MapType.hybrid,
          initialCameraPosition: CameraPosition(
              target:
                  LatLng(widget.branches.latitude, widget.branches.longitude),
              bearing: 192.8334901395799,
              //tilt: 59.440717697143555,
              zoom: 18.151926040649414),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
