import 'package:bloodlink/screens/createBloodRequest.dart';
import 'package:bloodlink/screens/editGender.dart';
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
import 'package:bloodlink/screens/viewActiveRequest.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:bloodlink/screens/editEmail.dart';
import 'editPassword.dart';
import 'editPhone.dart';
import 'editBlood.dart';
import 'editAge.dart';
import 'editName.dart';

class editPageProfile extends StatefulWidget {
  editPageProfile({Key? key}) : super(key: key);
  var isDonor = UserSimplePreferences.getisDonor();

  @override
  State<editPageProfile> createState() => _editPageProfileState();
}

class _editPageProfileState extends State<editPageProfile>
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
        backgroundColor: Colors.white,
        body: Center(
          child: Container(
            width: width,
            child: ListView(children: <Widget>[
              Column(
                children: [
                  AppBarFb2(),
                  CardWithIconInitiateRequest(
                    text: "Edit Name",
                    func: "name",
                  ),
                  CardWithIconInitiateRequest(
                    text: "Edit Email",
                    func: "email",
                  ),
                  CardWithIconInitiateRequest(
                    text: "Edit Password",
                    func: "password",
                  ),
                  CardWithIconInitiateRequest(
                    text: "Edit Phone",
                    func: "phone",
                  ),
                  CardWithIconInitiateRequest(
                    text: "Edit Blood Group",
                    func: "blood",
                  ),
                  CardWithIconInitiateRequest(
                    text: "Edit Gender",
                    func: "gender",
                  ),
                  CardWithIconInitiateRequest(
                    text: "Edit Age",
                    func: "age",
                  ),
                ],
              ),
            ]),
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

class CardWithIconInitiateRequest extends StatelessWidget {
  @override
  final String text;
  final String func;
  CardWithIconInitiateRequest(
      {required this.text, required this.func, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: MediaQuery.of(context).size.width * 0.1),
      // left: MediaQuery.of(context).size.width * 0.05),
      child: Card(
        elevation: 10,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () => {
            if (func == "email")
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => editEmail(key: key)))
            else if (func == "password")
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => editPassword(key: key)))
            // else if (func == "phone")
            //   Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => editPhone(key: key)))
            // else if (func == "age")
            //   Navigator.of(context).push(
            //       MaterialPageRoute(builder: (context) => editPhone(key: key)))
            else if (func == "blood")
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => editBlood(key: key)))
            else if (func == "name")
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => editName(key: key)))
            else if (func == "gender")
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => editGender(key: key)))
          },
          // onTap: () => {},
          // print('Card tapped.');
          child: SizedBox(
              width: MediaQuery.of(context).size.width *
                  0.85, // determines the size of the card
              height: MediaQuery.of(context).size.height * 0.12,
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    alignment: AlignmentDirectional(-1, 0),
                    padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text(
                      text,
                      textAlign: TextAlign.left,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: MediaQuery.of(context).size.width * 0.05),
                    ),
                  ),

                  //
                ],
              )),
        ),
      ),
    );
    // InfoCard(title: "Use my Current Location", onMoreTap: null)
  }
}
