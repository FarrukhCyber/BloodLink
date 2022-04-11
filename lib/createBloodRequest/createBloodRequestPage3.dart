// import 'package:google_maps_flutter/google_maps_flutter.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class CreateBloodRequestPage3 extends StatelessWidget {
  const CreateBloodRequestPage3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      body: Column(
        children: <Widget>[
          GetLocationFromUser()
          // AppBarFb2(),
          // TopBarFb3(
          //     title: "Initiate a Request",
          //     upperTitle: "\nWhere is the blood required"),
        ],
      ),
    );
  }
}

// class GetLocationFromUser extends StatelessWidget {
//   const GetLocationFromUser({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: GoogleMap(
//       onMapCreated: null,
//       initialCameraPosition: const CameraPosition(
//         target: LatLng(0, 0),
//         zoom: 2,
//       ),
//     ));
//     // markers: _markers.values.toSet(),
//   }
// }

class GetLocationFromUser extends StatefulWidget {
  const GetLocationFromUser({Key? key}) : super(key: key);

  @override
  _GetLocationFromUSer createState() => _GetLocationFromUSer();
}

class _GetLocationFromUSer extends State<GetLocationFromUser> {
  final LatLng _initialcameraposition = const LatLng(20.5937, 78.9629);
  late GoogleMapController _controller;
  final Location _location = Location();

  void _onMapCreated(GoogleMapController _cntlr) {
    _controller = _cntlr;
    _location.onLocationChanged.listen((l) {
      _controller.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: LatLng(l.latitude!, l.longitude!), zoom: 15),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      // width: 200,
      // height: 300,
      child: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: const CameraPosition(
          target: LatLng(0, 0),
          zoom: 2,
        ),
        // markers: _markers.values.toSet(),
      ),
    );
  }
}
