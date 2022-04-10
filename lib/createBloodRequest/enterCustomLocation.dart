import 'package:create_blood_request/createBloodRequest/createBloodRequest.dart';
import 'package:create_blood_request/createBloodRequest/createBloodRequestPage2.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

// class EnterCustomLocation extends StatelessWidget {
//   const EnterCustomLocation({Key? key}) : super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Color.fromARGB(255, 229, 229, 229),
//       body: Column(
//         children: <Widget>[
//           AppBarFb2(),
//           TopBarFb3(
//               title: "Initiate a Request",
//               upperTitle:
//                   "Please provide the required \n information to initiate a \n blood request"),
//         ],
//       ),
//     );
//   }
// }

// class TopBarFb3 extends StatelessWidget {
//   final String title;
//   final String upperTitle;
//   TopBarFb3({required this.title, required this.upperTitle, Key? key})
//       : super(key: key);
//   final primaryColor = Color.fromARGB(255, 222, 44, 44);
//   final secondaryColor = const Color(0xff6D28D9);
//   final accentColor = const Color(0xffffffff);
//   final backgroundColor = const Color(0xffffffff);
//   final errorColor = const Color(0xffEF4444);
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height * 0.15,
//       decoration: BoxDecoration(
//           color: primaryColor,
//           borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
//       // gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
//       // child: Padding(
//       //   padding: const EdgeInsets.all(25.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Text(title,
//           //     textAlign: TextAlign.center,
//           //     style: const TextStyle(
//           //         color: Colors.white70,
//           //         fontSize: 20,
//           //         fontWeight: FontWeight.bold)),
//           Center(
//               child: Text(upperTitle,
//                   textAlign: TextAlign.center,
//                   style: const TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.normal)))
//         ],
//       ),
//       // ),
//     );
//   }
// }

// class AppBarFb2 extends StatelessWidget with PreferredSizeWidget {
//   @override
//   final Size preferredSize;

//   AppBarFb2({Key? key})
//       : preferredSize = const Size.fromHeight(56.0),
//         super(key: key);
//   @override
//   Widget build(BuildContext context) {
//     const primaryColor = Color(0xffde2c2c);
//     const secondaryColor = Color(0xff6D28D9);
//     const accentColor = Color(0xffffffff);
//     const backgroundColor = Color(0xffffffff);
//     const errorColor = Color(0xffEF4444);

//     return AppBar(
//       centerTitle: true,
//       title: const Text("BloodLink", style: TextStyle(color: Colors.white)),
//       backgroundColor: primaryColor,
//       actions: [
//         // IconButton(
//         // icon: Icon(
//         // Icons.share,
//         // color: accentColor,
//         // ),
//         // onPressed: () {},
//         // )
//       ],
//       leading: IconButton(
//           icon: Icon(
//             Icons.keyboard_arrow_left,
//             color: accentColor,
//           ),
//           onPressed: () => Navigator.of(context).push(MaterialPageRoute(
//               builder: (context) => CreateBloodRequestPage2(key: key)))),
//     );
//   }
// }

class EnterCustomLocation extends StatefulWidget {
  const EnterCustomLocation({Key? key}) : super(key: key);

  @override
  State<EnterCustomLocation> createState() => _EnterCustomLocationState();
}

class _EnterCustomLocationState extends State<EnterCustomLocation> {
  static const _initialCameraPosition =
      CameraPosition(target: LatLng(31.4719859, 74.4173536), zoom: 11.5);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
          myLocationButtonEnabled: false,
          zoomControlsEnabled: false,
          initialCameraPosition: _initialCameraPosition),
    );
  }
}
