import 'package:bloodlink/screens/createBloodRequest.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;

class aboutPage extends StatefulWidget {
  aboutPage({Key? key}) : super(key: key);

  @override
  State<aboutPage> createState() => _aboutPageState();
}

class _aboutPageState extends State<aboutPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  String aboutContent = "Loading...";
  String lcssContent = "Loading...";
  String lumsContent = "Loading...";
  String bloodlinkContent = "Loading...";

  getData() async {
    String temp1 = await rootBundle.loadString("assets/about.txt");
    String temp2 = await rootBundle.loadString("assets/lcss.txt");
    String temp3 = await rootBundle.loadString("assets/lums.txt");
    String temp4 = await rootBundle.loadString("assets/bloodlink.txt");

    setState(() {
      aboutContent = temp1;
      lcssContent = temp2;
      lumsContent = temp3;
      bloodlinkContent = temp4;
    });
  }

  @override
  void initState() {
    getData();
    _controller = AnimationController(vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    // var aboutSize = MediaQuery.of(context).size.width * 0.12;
    var headSize = MediaQuery.of(context).size.width * 0.05;
    var paraSize = MediaQuery.of(context).size.width * 0.05;
    var imgSize = MediaQuery.of(context).size.width * 0.2;
    var dist = MediaQuery.of(context).size.height * 0.01;
    var mar = MediaQuery.of(context).size.width * 0.05;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Center(
            child: Container(
              width: width,
              child: Column(
                children: [
                  AppBarFb2(),
                  Container(
                    margin: EdgeInsets.only(left: mar, right: mar),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.width * 0.05),
                          child: Text(
                            aboutContent,
                            style: TextStyle(fontSize: paraSize),
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.width * 0.1,
                        ),
                        Container(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).size.width * 0.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceEvenly, //Center Row contents horizontally,
                            children: [
                              Image.asset(
                                "assets/lcss_logo.png",
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              // Container(
                              //   padding: EdgeInsets.only(
                              //       left: MediaQuery.of(context).size.width * 0.1),
                              // ),
                              Image.asset(
                                "assets/lums_logo_2.png",
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                              // Container(
                              //   padding: EdgeInsets.only(
                              //       left: MediaQuery.of(context).size.width * 0.1),
                              // ),
                              Image.asset(
                                "assets/bloodlink.png",
                                width: MediaQuery.of(context).size.width * 0.2,
                              ),
                            ],
                          ),
                        ),
                        infoFunc("LUMS", "assets/lums_logo_2.png", lumsContent,
                            headSize, paraSize, imgSize, dist),
                        infoFunc("LCSS", "assets/lcss_logo.png", lcssContent,
                            headSize, paraSize, imgSize, dist),
                        infoFunc(
                            "Bloodlink",
                            "assets/bloodlink.png",
                            bloodlinkContent,
                            headSize,
                            paraSize,
                            imgSize,
                            dist),
                      ],
                    ),
                  )

                  // TopBarFb3(
                  //   title: "BloodLink",
                  // ),
                ],
              ),
            ),
          ),
        ],
      ),
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
    const primaryColor = Color(0xffc10110);
    const secondaryColor = Color(0xff6D28D9);
    const accentColor = Color(0xffffffff);
    const backgroundColor = Color(0xffffffff);
    const errorColor = Color(0xffEF4444);

    return AppBar(
      centerTitle: true,
      title: const Text("About Us", style: TextStyle(color: Colors.white)),
      backgroundColor: primaryColor,
    );
  }
}

class TopBarFb3 extends StatelessWidget {
  final String title;
  TopBarFb3({required this.title, Key? key}) : super(key: key);
  final primaryColor = Color(0xffc10110);
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
            color: Colors.yellow,
            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.15,
          decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60))),
          child: Row(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Image.asset(
                'assets/bloodlink.png',
                width: MediaQuery.of(context).size.width * 0.2,
                color: Colors.white,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Image.asset(
                'assets/lums_logo_2.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
              ),
              Image.asset(
                'assets/lcss_logo.png',
                width: MediaQuery.of(context).size.width * 0.2,
              ),
            ],
          ),
        ));
  }
}

headingDecoration(headSize) {
  return TextStyle(fontSize: headSize, fontWeight: FontWeight.bold);
}

paraDecoration(paraSize) {
  return TextStyle(fontSize: paraSize);
}

infoFunc(heading, logo, content, headSize, paraSize, imgSize, dist) {
  return Container(
    padding: EdgeInsets.only(top: dist, bottom: dist),
    child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(
          //   height: dist,
          // ),
          Text(
            heading,
            style: headingDecoration(headSize),
            textAlign: TextAlign.start,
          ),
          SizedBox(
            height: dist * .1,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                // padding: EdgeInsets.only(left: dist, right: dist),
                child: Expanded(
                  child: Text(
                    content,
                    style: paraDecoration(paraSize),
                  ),
                ),
              ),
              // Image.asset(
              //   logo,
              //   width: imgSize,
              //   alignment: Alignment.centerRight,
              // ),
            ],
          ),
          // Divider(
          //   thickness: 2,
          //   color: Color(0xFFF44336),
          // ),
        ]),
  );
}
