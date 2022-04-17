import 'package:bloodlink/screens/createBloodRequest.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:bloodlink/screens/registerDonor.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/widgets/navbar.dart';
import 'package:bloodlink/widgets/optionCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:bloodlink/screens/myRequests.dart';

class homepage extends StatefulWidget {
  final String userName;
  const homepage({Key? key, required this.userName}) : super(key: key);

  @override
  State<homepage> createState() => _homepageState();
}

class _homepageState extends State<homepage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    return Scaffold(
        drawer: navBar(
          userName: widget.userName,
          userEmail: "Email",
        ),
        body: Center(
          child: Container(
            width: width,
            child: Column(
              children: [
                AppBarFb2(),
                TopBarFb3(title: "BloodLink", upperTitle: "Welcome"),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateBloodRequest()));
                    },
                    child: SizedBox(
                        width: width * 0.85, // determines the size of the card
                        height: 100,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: AlignmentDirectional(-1, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'Initiate a new request',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color(0xff24A979),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional(1, 0),
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                MdiIcons.plusCircle,
                                color: Color(0xff24A979),
                                size: 30,
                              ),
                            ),
                            //
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      print('Card tapped.');
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => activeRequests()));
                    },
                    child: SizedBox(
                        width: width * 0.85, // determines the size of the card
                        height: 100,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: AlignmentDirectional(-1, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'View Active Requests',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 113, 98, 13),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional(1, 0),
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                MdiIcons.clock,
                                color: Color.fromARGB(255, 113, 98, 13),
                                size: 30,
                              ),
                            ),
                            //
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => registerDonor()));
                      print('Card tapped.');
                    },
                    child: SizedBox(
                        width: width * 0.85, // determines the size of the card
                        height: 100,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: AlignmentDirectional(-1, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'Register as a donor',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: red, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional(1, 0),
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                MdiIcons.heart,
                                color: red,
                                size: 30,
                              ),
                            ),
                            //
                          ],
                        )),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  elevation: 10,
                  child: InkWell(
                    splashColor: Colors.blue.withAlpha(30),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => myRequests()));
                      print('Card tapped.');
                    },
                    child: SizedBox(
                        width: width * 0.85, // determines the size of the card
                        height: 100,
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              alignment: AlignmentDirectional(-1, 0),
                              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                              child: Text(
                                'View My Requests',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 113, 98, 13),
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Container(
                              alignment: AlignmentDirectional(1, 0),
                              padding: EdgeInsets.fromLTRB(0, 0, 10, 0),
                              child: Icon(
                                MdiIcons.clock,
                                color: Color.fromARGB(255, 113, 98, 13),
                                size: 30,
                              ),
                            ),
                            //
                          ],
                        )),
                  ),
                ),
              ],
            ),
          ),
        ));
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
      // leading: IconButton(
      //   icon: Icon(
      //     Icons.keyboard_arrow_left,
      //     color: accentColor,
      //   ),
      //   onPressed: () {},
    );
  }
}

//contains "personal information" and edit button
class Heading extends StatelessWidget {
  final String title;
  Heading({required this.title, Key? key}) : super(key: key);
  final primaryColor = const Color.fromARGB(255, 222, 44, 44);
  final secondaryColor = const Color(0xff6D28D9);
  final accentColor = const Color(0xffffffff);
  final backgroundColor = const Color(0xffffffff);
  final errorColor = const Color(0xffEF4444);
  final double borderRadius = 15;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.08,
      decoration: BoxDecoration(color: accentColor),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title, // this is personal information
            style: const TextStyle(
                color: Color.fromARGB(255, 222, 44, 44),
                fontSize: 15,
                fontWeight: FontWeight.bold),
            // textAlign: TextAlign.left,
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width * 0.40),
                child: ElevatedButton(
                  style: ButtonStyle(
                      elevation: MaterialStateProperty.all(0),
                      alignment: Alignment.centerRight,
                      padding: MaterialStateProperty.all(const EdgeInsets.only(
                          right: 20, left: 20, top: 10, bottom: 10)),
                      backgroundColor: MaterialStateProperty.all(primaryColor),
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(borderRadius)),
                      )),
                  onPressed: () => print("Edit clicked"),
                  child: Text(
                    "Edit",
                    style: TextStyle(color: Color(0xffffffff), fontSize: 16),
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

//the second bar
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
              child: Text(upperTitle,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.normal)))
        ],
      ),
    );
  }
}
