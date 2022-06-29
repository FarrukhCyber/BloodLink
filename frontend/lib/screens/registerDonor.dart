import 'dart:convert';
import 'package:bloodlink/screens/myRequests.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:bloodlink/utils/user_info.dart';
import 'package:bloodlink/screens/networkHandler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bloodlink/screens/homepage.dart';

String bloodGroupSelection = "";
String genderSelection = "";
String city = "";
String phoneNumber = "";
bool diabetesSelection = false;
bool plasmaSelection = false;
bool diseaseSelect = false;
bool vaccinatedSelect = false;
DateTime dateSelection = DateTime.now();

class registerDonor extends StatefulWidget {
  const registerDonor({Key? key}) : super(key: key);

  @override
  State<registerDonor> createState() => _registerDonorState();
}

class _registerDonorState extends State<registerDonor> {
  final listDropdown = <String>['Choose', 'Yes', 'No'];
  NetworkHandler networkHandler = NetworkHandler();
  TextEditingController phoneController = TextEditingController();

  errorGenerator(context, title, message) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Navigator.pop(context, 'Ok'),
                  child: const Text('Ok'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 229, 229, 229),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            AppBarFb2(context),
            TopBarFb3(context, "Donor Registeration"),
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  const Text(
                    "Please provide these details to register as donor.",
                    style: TextStyle(
                      fontSize: 14,
                      //fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  NumberFieldWithLabel(
                      context, "3xxxxxxxxx", "Contact Number", phoneController),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  Text(
                    'Region',
                    style: TextStyle(
                      fontSize: 12,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.015,
                  ),
                  RegionDropDown(context),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    'Are you diabetic?',
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  DropDownMenu(
                      item: listDropdown,
                      dropDownValue: "Choose",
                      selection: "diabetes"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    "Do you have any Blood Disorder?",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  DropDownMenu(
                      item: listDropdown,
                      dropDownValue: "Choose",
                      selection: "disease"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    "Will you donate plasma too?",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  DropDownMenu(
                      item: listDropdown,
                      dropDownValue: "Choose",
                      selection: "plasma"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),
                  Text(
                    "Are you vaccinated?",
                    style: TextStyle(
                      fontSize: 13,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  //SizedBox(height: MediaQuery.of(context).size.height * 0.01),
                  DropDownMenu(
                      item: listDropdown,
                      dropDownValue: "Choose",
                      selection: "vaccine"),
                  getDate(title: "Please select a date"),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.015),

                  NextButton(context, "Register", 50)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget NextButton(context, label, double pad) {
    return Container(
      //margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
      child: SizedBox(
        // height: MediaQuery.of(context).size.width * 0.1,
        // width: MediaQuery.of(context).size.width * 0.1,
        child: ElevatedButton(
          //padding: EdgeInsets.all(1.0),
          //olor: Color(0xffc10110),
          style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all(Colors.white),
              backgroundColor: MaterialStateProperty.all(Color(0xffc10110)),
              padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                  EdgeInsets.symmetric(vertical: 10, horizontal: pad)),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ))),
          onPressed: () async {
            print(bloodGroupSelection);
            print(genderSelection);
            print(UserSimplePreferences.getPhoneNumber());
            print(city);
            print(vaccinatedSelect);
            print(diseaseSelect);
            print(plasmaSelection);
            print(diabetesSelection);
            print(dateSelection);
            var res = await networkHandler.get(
                '/donor_auth', userPhoneNum, "user_contact_num");
            var message = json.decode(res.body);
            var msg = message["msg"];
            print("msg: ${msg}");
            if (bloodGroupSelection == "Choose" ||
                diseaseSelect == "Choose" ||
                diseaseSelect == "Choose" ||
                vaccinatedSelect == "Choose" ||
                city == "" ||
                plasmaSelection == "Choose") {
              errorGenerator(context, "Empty Fields", "Please fill all fields");
            } else if (msg == "exists") {
              errorGenerator(
                  context, "Donor Exists", "Already Registered as Donor");
            } else if (msg == "unique") {
              Map<String, dynamic> res = {
                'user_contact_num': UserSimplePreferences.getPhoneNumber(),
                "blood_group": UserSimplePreferences.getBloodType(),
                "diabetes": diseaseSelect,
                "blood_disease": diseaseSelect,
                "vaccinated": vaccinatedSelect,
                "last_donated": dateSelection.toString(),
                "region": city,
                "gender": UserSimplePreferences.getGender(),
                "plasma": plasmaSelection
              };
              UserSimplePreferences.setRegion(city); // THIS IS NEW
              var responseRegister =
                  await networkHandler.post('/register_donor/add', res);
              print("waiting for server");
              if (responseRegister.statusCode == 200 ||
                  responseRegister.statusCode == 201) {
                print('successful');
                Fluttertoast.showToast(
                    msg: "Registeration successful",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.CENTER,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Color(0xffc10110),
                    textColor: Colors.white,
                    fontSize: 16.0);
                UserSimplePreferences.setisDonor("true");
                var key;
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => homepage(
                        userName: UserSimplePreferences.getUsername() ?? "",
                        key: key)));
              } else {
                errorGenerator(context, 'There was an error in server',
                    'Please try again in some time');
                print('unsucessful');
              }
            } else if (msg == "error") {
              errorGenerator(context, 'There was an error in server',
                  'Please try again in some time');
            }
          },
          child: Text(
            label,
            style: TextStyle(color: Colors.white, fontSize: 18.0),
          ),
        ),
      ),
    );
  }

  Widget TopBarFb3(BuildContext context, upperTitle) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
          color: Color(0xffc10110),
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
                      fontSize: 18,
                      fontWeight: FontWeight.normal)))
        ],
      ),
      // ),
    );
  }

  @override
  Widget AppBarFb2(BuildContext context) {
    const accentColor = Color(0xffffffff);

    var key;
    return AppBar(
      centerTitle: true,
      title: const Text("BloodLink", style: TextStyle(color: Colors.white)),
      backgroundColor: Color(0xffc10110),
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
        onPressed: () => Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => homepage(
                  key: key,
                  userName: "user",
                ))),
      ),
    );
  }

  @override
  Widget InputFieldWithLabel(
      BuildContext context, hintText, labelText, inputController) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      // height: MediaQuery.of(context).size.height * 0.5,
      // height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.grey.withOpacity(.1)),
      ]),
      // padding: const EdgeInsets.all(right: 20, left: 20, top: 10, bottom: 10),
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.05, 0, 0),
      child: TextField(
        controller: inputController,
        onChanged: (value) {
          //Do something with value
        },
        keyboardType: TextInputType.name,
        style:
            const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffc10110).withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffc10110), width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffc10110).withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }

  @override
  Widget RegionDropDown(BuildContext context) {
    String countryValue = "";
    String stateValue = "";
    String cityValue = "";
    String address = "";
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      height: 100,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ///Adding CSC Picker Widget in app
          CSCPicker(
            ///Enable disable state dropdown [OPTIONAL PARAMETER]
            ///
            ///
            showStates: true,

            /// Enable disable city drop down [OPTIONAL PARAMETER]
            showCities: true,

            ///Enable (get flag with country name) / Disable (Disable flag) / ShowInDropdownOnly (display flag in dropdown only) [OPTIONAL PARAMETER]
            flagState: CountryFlag.DISABLE,

            ///Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER] (USE with disabledDropdownDecoration)
            dropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.white, width: 1)),

            ///Disabled Dropdown box decoration to style your dropdown selector [OPTIONAL PARAMETER]  (USE with disabled dropdownDecoration)
            disabledDropdownDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Colors.white,
                border: Border.all(color: Colors.grey, width: 1)),

            ///placeholders for dropdown search field
            countrySearchPlaceholder: "Pakistan",
            stateSearchPlaceholder: "State",
            citySearchPlaceholder: "City",

            ///labels for dropdown
            stateDropdownLabel: "Province",
            cityDropdownLabel: "City",

            ///Default Country
            defaultCountry: DefaultCountry.Pakistan,

            ///Disable country dropdown (Note: use it with default country)
            disableCountry: true,

            ///selected item style [OPTIONAL PARAMETER]
            selectedItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///DropdownDialog Heading style [OPTIONAL PARAMETER]
            dropdownHeadingStyle: TextStyle(
                color: Colors.black, fontSize: 14, fontWeight: FontWeight.bold),

            ///DropdownDialog Item style [OPTIONAL PARAMETER]
            dropdownItemStyle: TextStyle(
              color: Colors.black,
              fontSize: 14,
            ),

            ///Dialog box radius [OPTIONAL PARAMETER]
            dropdownDialogRadius: 5.0,

            ///Search bar radius [OPTIONAL PARAMETER]
            searchBarRadius: 5.0,

            ///triggers once country selected in dropdown

            ///triggers once state selected in dropdown
            onCountryChanged: (value) {
              setState(() {
                ///store value in state variable
                stateValue = value;
              });
            },
            onStateChanged: (value) {
              setState(() {
                ///store value in state variable
                stateValue = value ?? "";
              });
            },

            ///triggers once city selected in dropdown
            onCityChanged: (value) {
              setState(() {
                ///store value in city variable
                cityValue = value ?? "";
                city = value ?? "";
              });
            },
          )
        ],
      ),
    );
  }

  @override
  Widget NumberFieldWithLabel(
      BuildContext context, hintText, labelText, inputController) {
    bool red = false;
    bool green = false;
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      // height: MediaQuery.of(context).size.height * 0.5,
      // height: 50,
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            offset: const Offset(12, 26),
            blurRadius: 50,
            spreadRadius: 0,
            color: Colors.white),
      ]),
      // padding: const EdgeInsets.all(right: 20, left: 20, top: 10, bottom: 10),
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.05, 0, 0),
      child: TextFormField(
        enabled: false,
        keyboardType: TextInputType.number,
        style:
            const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: "    " + UserSimplePreferences.getPhoneNumber()!,
          //hintText: UserSimplePreferences.getPhoneNumber(),
          hintStyle: TextStyle(color: Colors.black),
          prefix: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Visibility(
              visible: true,
              child: Text(
                '(+92)',
                style: TextStyle(
                  fontSize: 16,
                  //fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          suffixIcon: const Icon(
            Icons.check_circle,
            color: Colors.green,
            size: 32,
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffc10110).withOpacity(.1), width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Color(0xffc10110), width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color(0xffc10110).withOpacity(.1), width: 2.0),
          ),
        ),
      ),
    );
  }
}

class DropDownMenu extends StatefulWidget {
  var item;
  String dropDownValue;
  String selection;
  DropDownMenu(
      {Key? key,
      required this.item,
      required this.dropDownValue,
      required this.selection})
      : super(key: key);

  @override
  State<DropDownMenu> createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.85,
        margin: EdgeInsets.fromLTRB(
            0, MediaQuery.of(context).size.height * 0.01, 0, 0),
        child: DropdownButton(
          value: widget.dropDownValue,
          icon: Icon(Icons.keyboard_arrow_down),
          items: widget.item.map<DropdownMenuItem<String>>((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              widget.dropDownValue = newValue!;
              if (widget.selection == 'vaccine') {
                vaccinatedSelect = newValue == 'Yes' ? true : false;
              } else if (widget.selection == 'disease') {
                diseaseSelect = newValue == 'Yes' ? true : false;
              } else if (widget.selection == 'plasma') {
                plasmaSelection = newValue == 'Yes' ? true : false;
              } else if (widget.selection == 'diabetes') {
                diabetesSelection = newValue == 'Yes' ? true : false;
              }
            });
          },
        ));
  }
}

class getDate extends StatefulWidget {
  getDate({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _DropDownState createState() => _DropDownState();
}

class _DropDownState extends State<getDate> {
  DateTime selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8),
      lastDate: DateTime(2101),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: ColorScheme.dark(
            primary: Color(0xffc10110),
            onPrimary: Colors.white,
            surface: Color(0xffc10110),
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child!,
      ),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dateSelection = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.03, 0, 0),
      child: Column(
        children: <Widget>[
          Row(children: [
            Text("When did you donate blood last time?",
                style: TextStyle(fontSize: 15)),
            SizedBox(
              width: 10,
            ),
            Text(
              "${selectedDate.toLocal()}".split(' ')[0],
              style: TextStyle(
                color: Color(0xffc10110),
                decoration: TextDecoration.underline,
              ),
            ),
          ]),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.015,
          ),
          OutlinedButton(
            //padding: EdgeInsets.all(1.0),
            //olor: Color(0xffc10110),
            style: ButtonStyle(
                // foregroundColor: MaterialStateProperty.all(Colors.white),
                backgroundColor: MaterialStateProperty.all(Colors.white),
                side: MaterialStateProperty.all(BorderSide(
                    color: Colors.grey, width: 2.0, style: BorderStyle.solid)),
                padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                    EdgeInsets.symmetric(vertical: 10, horizontal: 50)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ))),
            onPressed: () => _selectDate(context),
            child: Text(
              "Select Date",
              style: TextStyle(color: Color(0xffc10110), fontSize: 18.0),
            ),
          ),
        ],
      ),
    );
  }
}
