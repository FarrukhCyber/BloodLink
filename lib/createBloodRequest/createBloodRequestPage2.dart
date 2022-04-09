import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

class CreateBloodRequestPage2 extends StatelessWidget {
  const CreateBloodRequestPage2({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      body: Column(
        children: <Widget>[
          AppBarFb2(),
          TopBarFb3(
              title: "Initiate a Request",
              upperTitle: "\nWhere is the blood required"),
          Container(
            margin:
                EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
            child: Card(
              elevation: 10,
              child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () {
                  print('Card tapped.');
                },
                child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.85,
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: Row(
                      children: [
                        Container(
                          alignment: Alignment.topLeft,
                          // padding: EdgeInsets.fromLTRB(5, 10, 0, 0),
                          padding: EdgeInsets.fromLTRB(
                              MediaQuery.of(context).size.width * 0.0250,
                              MediaQuery.of(context).size.width * 0.0120,
                              0,
                              0),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Column(
                                // mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Use my current location',
                                    style: TextStyle(
                                        color: Color.fromARGB(255, 222, 44, 44),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    textAlign: TextAlign.right,
                                  ),
                                  Expanded(
                                    child: Text(
                                      '\n Use your current location as requested\n location',
                                      style: TextStyle(
                                          color: Color.fromARGB(255, 0, 0, 0),
                                          // fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.04),
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.2,
                              left: MediaQuery.of(context).size.width * 0.03),
                          child: Icon(
                            Icons.my_location,
                            color: Color.fromARGB(255, 222, 44, 44),
                            size: 30,
                          ),
                        ),
                        //
                      ],
                    )),
              ),
            ),
          ),
          // InfoCard(title: "Use my Current Location", onMoreTap: null)
        ],
      ),
    );
  }
}

class TopBarFb3 extends StatelessWidget {
  final String title;
  final String upperTitle;
  TopBarFb3({required this.title, required this.upperTitle, Key? key})
      : super(key: key);
  final primaryColor = Color.fromARGB(255, 222, 44, 44);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.15,
      decoration: BoxDecoration(
          color: primaryColor,
          borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
      // gradient: LinearGradient(colors: [primaryColor, secondaryColor])),
      // child: Padding(
      //   padding: const EdgeInsets.all(25.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(title,
          //     textAlign: TextAlign.center,
          //     style: const TextStyle(
          //         color: Colors.white70,
          //         fontSize: 20,
          //         fontWeight: FontWeight.bold)),
          Center(
              child: Text(upperTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal)))
        ],
      ),
      // ),
    );
  }
}

class AppBarFb2 extends StatelessWidget with PreferredSizeWidget {
  @override
  final Size preferredSize;

  AppBarFb2({Key? key})
      : preferredSize = const Size.fromHeight(56.0),
        super(key: key);
  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xffde2c2c);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return AppBar(
      centerTitle: true,
      title: const Text("BloodLink", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      // actions: [
      // IconButton(
      // icon: Icon(
      // Icons.share,
      // color: accentColor,
      // ),
      // onPressed: () {},
      // )
      // leading: IconButton(
      //     icon: Icon(
      //       Icons.keyboard_arrow_left,
      //       color: accentColor,
      //     ),
      //     onPressed: () => {}),
    );
  }
}

// class InfoCard extends StatelessWidget {
//   final String title;
//   final String body;
//   final Function() onMoreTap;

//   final String subInfoTitle;
//   final String subInfoText;
//   final Widget subIcon;

//   const InfoCard(
//       {required this.title,
//       this.body =
//           """Lorem ipsum dolor sit amet consectetur adipisicing elit. Maxime mollitia, molestiae quas vel sint commodi repudi conseqr!""",
//       required this.onMoreTap,
//       this.subIcon = const CircleAvatar(
//         child: Icon(
//           Icons.directions,
//           color: Colors.white,
//         ),
//         backgroundColor: Colors.orange,
//         radius: 25,
//       ),
//       this.subInfoText = "545 miles",
//       this.subInfoTitle = "Directions",
//       Key? key})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(25.0),
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25.0),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(.05),
//               offset: Offset(0, 10),
//               blurRadius: 0,
//               spreadRadius: 0,
//             )
//           ],
//           gradient: RadialGradient(
//             colors: [Colors.orangeAccent, Colors.orange],
//             focal: Alignment.topCenter,
//             radius: .85,
//           )),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 title,
//                 style: TextStyle(
//                     color: Colors.white,
//                     fontSize: 26,
//                     fontWeight: FontWeight.bold),
//               ),
//               Container(
//                 width: 75,
//                 height: 30,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(100.0),
//                   gradient: LinearGradient(
//                       colors: [Colors.white, Colors.white],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter),
//                 ),
//                 child: GestureDetector(
//                   onTap: onMoreTap,
//                   child: Center(
//                       child: Text(
//                     "More",
//                     style: TextStyle(color: Colors.orange),
//                   )),
//                 ),
//               ),
//             ],
//           ),
//           SizedBox(height: 10),
//           Text(
//             body,
//             style:
//                 TextStyle(color: Colors.white.withOpacity(.75), fontSize: 14),
//           ),
//           SizedBox(height: 15),
//           Container(
//             width: double.infinity,
//             height: 75,
//             decoration: BoxDecoration(
//               borderRadius: BorderRadius.circular(25.0),
//               color: Colors.white,
//             ),
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Row(
//                 children: [
//                   subIcon,
//                   SizedBox(width: 10),
//                   Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(subInfoTitle),
//                       Text(
//                         subInfoText,
//                         style: TextStyle(
//                           color: Colors.orange,
//                           fontSize: 22,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   )
//                 ],
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
