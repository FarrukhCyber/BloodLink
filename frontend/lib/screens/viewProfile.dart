import 'package:bloodlink/screens/addDonor.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:bloodlink/screens/editEmail.dart';
import 'package:bloodlink/screens/editPhone.dart';
import 'package:bloodlink/screens/editAge.dart';
import 'package:bloodlink/screens/editName.dart';
import 'package:bloodlink/screens/editBlood.dart';
import 'package:bloodlink/screens/editPassword.dart';
import 'package:bloodlink/screens/editGender.dart';
import 'package:bloodlink/screens/editRegion.dart';

var isDonor = UserSimplePreferences.getisDonor();
var dividerColor = Color(0xffc10110);

class viewProfile extends StatefulWidget {
  const viewProfile({Key? key}) : super(key: key);

  @override
  State<viewProfile> createState() => _viewProfileState();
}

class _viewProfileState extends State<viewProfile>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    print(isDonor);
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
                  TopBarFb3(
                      title: "BloodLink", upperTitle: "\nProfile Information"),
                  Padding(padding: EdgeInsets.fromLTRB(0, 5, 0, 10)),
                  editSomething2(
                    text: "Name",
                    func: "name",
                    value: UserSimplePreferences.getUsername() ?? "404",
                  ),
                  editSomething2(
                    text: "Email",
                    func: "email",
                    value: UserSimplePreferences.getEmail() ?? "404",
                  ),
                  editSomething2(
                    text: "Password",
                    func: "password",
                    value: UserSimplePreferences.getPassword() ?? "404",
                  ),
                  editSomething2(
                    text: "Phone Number",
                    func: "phone",
                    value: UserSimplePreferences.getPhoneNumber() ?? "404",
                  ),
                  editSomething2(
                    text: "Blood Group",
                    func: "blood",
                    value: UserSimplePreferences.getBloodType() ?? "404",
                  ),
                  editSomething2(
                    text: "Gender",
                    func: "gender",
                    value: UserSimplePreferences.getGender() ?? "404",
                  ),
                  editSomething2(
                    text: "Age",
                    func: "age",
                    value: UserSimplePreferences.getAge() ?? "404",
                  ),
                  isDonor == "true"
                      ? editSomething2(
                          text: "Region",
                          func: "region",
                          value: UserSimplePreferences.getRegion() ?? "404",
                        )
                      : Text("")
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
    );
  }
}

class Heading extends StatelessWidget {
  final String title;
  Heading({required this.title, Key? key}) : super(key: key);
  final primaryColor = Color(0xffc10110);
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
                color: Color(0xffc10110),
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
                  onPressed: () => {
                    print("going to view"),
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => viewProfile()))
                  },
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

class editSomething2 extends StatelessWidget {
  @override
  final String text;
  final String func;
  final String value;
  editSomething2(
      {required this.text, required this.func, required this.value, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var ht = MediaQuery.of(context).size.width * 0.05;
    return Container(
      margin: EdgeInsets.only(top: ht),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(text, style: TextStyle(fontSize: 20)),
            SizedBox(
              height: ht * .5,
            ),
            Text(
              value,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(height: ht * .5),
            Divider(
              color: dividerColor,
              thickness: 1,
            ),
            SizedBox(height: ht * .5),
            Align(
              alignment: Alignment(1, 0),
              child: InkWell(
                onTap: () => {
                  if (func == "email")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editEmail(key: key)))
                  else if (func == "password")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editPassword(key: key)))
                  else if (func == "phone")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editPhone(
                              forget: false,
                            )))
                  else if (func == "age")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editAge(key: key)))
                  else if (func == "blood")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editBlood(key: key)))
                  else if (func == "name")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editName(key: key)))
                  else if (func == "region")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editRegion(key: key)))
                  else if (func == "gender")
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => editGender(key: key)))
                },
                child: Text(
                  "Edit",
                  style: TextStyle(color: Colors.red, fontSize: 15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
