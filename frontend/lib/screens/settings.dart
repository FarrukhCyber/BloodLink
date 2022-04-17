import 'package:bloodlink/screens/createBloodRequest.dart';
import 'package:bloodlink/screens/login.dart';
import 'package:bloodlink/screens/registerDonor.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/widgets/navbar.dart';
import 'package:bloodlink/widgets/optionCard.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:material_design_icons_flutter/icon_map.dart';
import 'package:bloodlink/screens/myRequests.dart';
import 'package:bloodlink/screens/viewActiveRequest.dart';

class Settings extends StatefulWidget {
  // final String userName;
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _homepageState();
}

class _homepageState extends State<Settings>
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
    var phoneNo = UserSimplePreferences.getPhoneNumber();
    return Scaffold(
        // backgroundColor: Color.fromARGB(255, 229, 229, 229),
        backgroundColor: Colors.white,
        body: Center(
            child: Container(
          width: width,
          child: ListView(children: <Widget>[
            Column(children: [
              AppBarFb2(),
              TopBarFb3(
                  title: "Settings",
                  upperTitle: "\n View and Edit your account settings"),
              TextwithCheckBox(
                title: "Send me an email in case of a blood request",
                symbol: Icons.check_box_rounded,
                label:"email"
              ),
              TextwithCheckBox(
                title: "Send me blood request notifications ",
                symbol: Icons.check_box_rounded,
                label:"notify"
              ),
              TextwithCheckBox(
                title: "Mark me unavailable for donation",
                symbol: Icons.check_box_rounded,
                label:"available"
              ),
              Container(
                padding: EdgeInsets.fromLTRB(
                    0, MediaQuery.of(context).size.width * 0.02, 0, 0),
                child: Column(
                  children: [
                    Divider(
                      thickness: 1,
                      color: Color(0xffc10110),
                      indent: MediaQuery.of(context).size.width * 0.05,
                      endIndent: MediaQuery.of(context).size.width * 0.05,
                    ),
                  ],
                ),
              ),
            ]),
          ]),
        )));
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

//the second bar
class TopBarFb3 extends StatelessWidget {
  final String title;
  final String upperTitle;
  TopBarFb3({required this.title, required this.upperTitle, Key? key})
      : super(key: key);
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

class TextwithCheckBox extends StatefulWidget {
  final String title;
  IconData symbol;
  TextwithCheckBox({required this.title, required this.symbol, Key? key})
      : super(key: key);

  @override
  State<TextwithCheckBox> createState() => _TextwithCheckBoxState();
}

class _TextwithCheckBoxState extends State<TextwithCheckBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.width * 0.02, 0, 0),
        child: Column(
          children: [
            Divider(
              thickness: 1,
              color: Color(0xffc10110),
              indent: MediaQuery.of(context).size.width * 0.05,
              endIndent: MediaQuery.of(context).size.width * 0.05,
            ),
            Container(
              padding: EdgeInsets.fromLTRB(
                  0, MediaQuery.of(context).size.width * 0.05, 0, 0),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        MediaQuery.of(context).size.width * 0.05, 0, 0, 0),
                    child: Text(
                      widget.title,
                      // textAlign: TextAlign.left,
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                  new Spacer(),
                  Container(
                    padding: EdgeInsets.fromLTRB(
                        0, 0, MediaQuery.of(context).size.width * 0.01, 0),
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            if (widget.symbol == Icons.check_box_rounded) {
                              widget.symbol = Icons.check_box_outline_blank;
                            } else {
                              widget.symbol = Icons.check_box_rounded;
                            }
                          });
                        },
                        icon: Icon(widget.symbol,
                            color: Color(0xffc10110),
                            size: MediaQuery.of(context).size.width * 0.08)),
                  )
                ],
              ),
            ),
          ],
        ));
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}
