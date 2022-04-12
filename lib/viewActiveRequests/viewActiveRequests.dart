import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';

class ViewActiveRequests extends StatelessWidget {
  const ViewActiveRequests({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      body: Column(
        children: <Widget>[
          AppBarFb2(),
          TopBarFb3(
              title: "Pending Requests",
              upperTitle:
                  "\nBelow are requests by \n the people who need Blood"),
          const RequestCard(
            name: "Muhammad Hassnain",
            bloodgroup: "O+",
            symbol: MdiIcons.plusCircle,
            date: "21 March",
            time: "3:00 pm",
            location: "National Hospital",
            // moreDetails: null,
          )
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
      title:
          const Text("Pending Requests", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
      actions: [
        // IconButton(
        // icon: Icon(
        // Icons.share,
        // color: accentColor,
        // ),
        // onPressed: () {},
        // )
      ],
      leading: IconButton(
        icon: Icon(
          Icons.keyboard_arrow_left,
          color: accentColor,
        ),
        onPressed: () {},
      ),
    );
  }
}

class RequestCard extends StatelessWidget {
  @override
  final String name;
  final String date;
  final String time;
  final String location;
  final IconData symbol;
  final String bloodgroup;
  // Function moreDetails;

  // final Size preferredSize;
  const RequestCard(
      {required this.name,
      required this.symbol,
      required this.date,
      required this.time,
      required this.location,
      required this.bloodgroup,
      // required this.moreDetails,
      Key? key})
      : super(key: key);
  // RequestCard({Key? key})
  //     // : preferredSize = const Size.fromHeight(56.0),
  //     : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.05),
        child: Card(
            elevation: 10,
            child: InkWell(
                splashColor: Colors.blue.withAlpha(30),
                onTap: () => {
                      print('Card tapped.')
                      // Navigator.of(context).push(MaterialPageRoute(
                      //     builder: (context) => EnterCustomLocation(
                      //           key: key,
                      // )))
                    },
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.85,
                  height: MediaQuery.of(context).size.height * 0.20,
                  child: Column(
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
                            Container(
                              width: MediaQuery.of(context).size.width * 0.1,
                              height: MediaQuery.of(context).size.width * 0.1,
                              child: TextButton(
                                style: TextButton.styleFrom(
                                    // primary: Colors.white,
                                    backgroundColor:
                                        Color(0xffde2c2c) // Text Color
                                    ),
                                onPressed: null,
                                child: Text(
                                  bloodgroup,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                      fontSize:
                                          MediaQuery.of(context).size.width *
                                              0.04),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.02,
                                      MediaQuery.of(context).size.width * 0.0,
                                      0,
                                      0),
                                  child: Text(
                                    name,
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.05),
                                    textAlign: TextAlign.right,
                                  ),
                                ),
                              ],
                            ),
                            Stack(
                              // mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      0,
                                      0,
                                      0),
                                  child: TextButton(
                                    // backgroundColor: Colors.white,
                                    onPressed: (() => {print("Share clicked")}),
                                    child: const Icon(
                                      Icons.share,
                                      color: Color(0xffde2c2c),
                                      // size: 20,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.085,
                                      MediaQuery.of(context).size.width * 0.09,
                                      0,
                                      0),
                                  child: Text(
                                    "Share",
                                    style: TextStyle(
                                        color: Color(0xffde2c2c),
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    // style: (Color(0xffde2c2c)m),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            0, MediaQuery.of(context).size.width * 0.02, 0, 0),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.125,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        0),
                                    child: Text(
                                      "Date",
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.fromLTRB(
                                        MediaQuery.of(context).size.width *
                                            0.125,
                                        MediaQuery.of(context).size.width *
                                            0.005,
                                        0,
                                        0),
                                    child: Text(
                                      date,
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ]),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    "Time",
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.05,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    time,
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.00,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Text(
                                    "Location",
                                    style: TextStyle(
                                        color: Colors.black,
                                        // fontWeight: FontWeight.bold,
                                        fontSize:
                                            MediaQuery.of(context).size.width *
                                                0.035),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.fromLTRB(
                                      MediaQuery.of(context).size.width * 0.1,
                                      MediaQuery.of(context).size.width * 0.005,
                                      0,
                                      0),
                                  child: Expanded(
                                    child: Text(
                                      location,
                                      style: TextStyle(
                                          color: Colors.black,
                                          // fontWeight: FontWeight.bold,
                                          fontSize: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.035),
                                      textAlign: TextAlign.left,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.fromLTRB(
                            MediaQuery.of(context).size.width * 0.52,
                            MediaQuery.of(context).size.width * 0.03,
                            0,
                            0),
                        child: Row(
                          children: [
                            Text("More Details",
                                style: TextStyle(
                                    color: Color(0xffde2c2c),
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        MediaQuery.of(context).size.width *
                                            0.035)),
                            Container(
                              height: MediaQuery.of(context).size.width * 0.1,
                              width: MediaQuery.of(context).size.width * 0.1,
                              child: TextButton(
                                  // backgroundColor:
                                  //     Colors.white.withOpacity(0.8),
                                  onPressed: null,
                                  child: const Icon(
                                    MdiIcons.plusCircle,
                                    color: Color(0xffde2c2c),
                                  )),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ))));
  }
}

class FloatingActionButtonFb3 extends StatelessWidget {
  final Function() onPressed;
  final Widget icon;
  final Color color;
  const FloatingActionButtonFb3(
      {required this.onPressed,
      required this.icon,
      this.color = Colors.blue,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: color,
      onPressed: onPressed,
      child: icon,
    );
  }
}

//helllo
