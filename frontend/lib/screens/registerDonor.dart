import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter_application_2/screens/registerDonorContinued.dart';

String bloodGroupSelection = "";
String genderSelection = "";
String city = "";
String phoneNumber = "";

class registerDonor extends StatefulWidget {
  const registerDonor({Key? key}) : super(key: key);

  @override
  State<registerDonor> createState() => _registerDonorState();
}

class _registerDonorState extends State<registerDonor> {
  final bloodGroups = <String>[
    'Choose a Blood Group',
    'A Positive (A+)',
    'A Negative (A-)',
    'B Positive (B+)',
    'B Negative (B-)',
    'AB Positive (AB+)',
    'AB Negative (AB-)',
    'O Positive (O+)',
    'O Negative (O-)'
  ];
  final gender = <String>['Choose Gender', 'Male', 'Female', 'Others'];
  final listDropdown = <String>['Choose', 'Yes', 'No'];

  TextEditingController phoneController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      body: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AppBarFb2(context),
          TopBarFb3(context, "Donor Registeration"),
          Padding(
            padding: EdgeInsets.all(20),
            child:
            Column(
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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.015,
                ),
                Text(
                  'Blood Group:',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * 0.010,),
                DropDownMenu(
                    item: bloodGroups,
                    dropDownValue: "Choose a Blood Group",
                    selection: "bloodGroup"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
                Text(
                  'Gender:',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.left,
                ),
                //SizedBox(height: MediaQuery.of(context).size.height * 0.010,),
                DropDownMenu(
                    item: gender,
                    dropDownValue: "Choose Gender",
                    selection: "gender"),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.010,
                ),
                NextButton("Continue", 0.7)
              ],
            ),),],
      ),
    );
  }

  Widget TopBarFb3(BuildContext context, upperTitle) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 222, 44, 44),
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

    return AppBar(
      centerTitle: true,
      title: const Text("BloodLink", style: TextStyle(color: Colors.white)),
      backgroundColor: Color.fromARGB(255, 222, 44, 44),
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
                color: Color.fromARGB(255, 222, 44, 44).withOpacity(.1),
                width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 222, 44, 44), width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 222, 44, 44).withOpacity(.1),
                width: 2.0),
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
            color: Colors.grey.withOpacity(.1)),
      ]),
      // padding: const EdgeInsets.all(right: 20, left: 20, top: 10, bottom: 10),
      margin: EdgeInsets.fromLTRB(
          0, MediaQuery.of(context).size.height * 0.05, 0, 0),
      child: TextFormField(
        controller: inputController,
        onChanged: (value) {
          setState(() {
            phoneNumber = "92"+phoneController.text;
            if (value.length == 10) {
              green = true;
            }
          });
        },
        keyboardType: TextInputType.number,
        style:
            const TextStyle(fontSize: 16, color: Color.fromARGB(255, 0, 0, 0)),
        decoration: InputDecoration(
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.withOpacity(.75)),
          fillColor: Colors.transparent,
          prefix: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 8),
            child: Text(
              '(+92)',
              style: TextStyle(
                fontSize: 16,
                //fontWeight: FontWeight.bold,
              ),
            ),
          ),
          suffixIcon: Visibility(
            visible: phoneController.text.length == 10,
            child: const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 32,
            ),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
          border: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 222, 44, 44).withOpacity(.1),
                width: 2.0),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide:
                BorderSide(color: Color.fromARGB(255, 222, 44, 44), width: 2.0),
          ),
          errorBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2.0),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
                color: Color.fromARGB(255, 222, 44, 44).withOpacity(.1),
                width: 2.0),
          ),
        ),
      ),
    );
  }

  Widget NextButton(label, pad) {
    return Container(
      //margin: EdgeInsets.fromLTRB(30.0, 5.0, 30.0, 5.0),
      child: ElevatedButton(
        //padding: EdgeInsets.all(1.0),
        //olor: Color.fromARGB(255, 193, 0, 0),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all(Colors.white),
            backgroundColor:
                MaterialStateProperty.all(Color.fromARGB(255, 193, 0, 0)),
            padding: MaterialStateProperty.all<EdgeInsetsGeometry>(
                EdgeInsets.symmetric(vertical: 10, horizontal: pad)),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ))),
        onPressed: () {
          print(bloodGroupSelection);
          print(genderSelection);
          print(phoneNumber);
          print(city);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => registerDonorContinued(bloodGroup:bloodGroupSelection,
                                                        gender:genderSelection,
                                                        contact:phoneNumber,
                                                        region:city),
          ));
        },
        child: Text(
          label,
          style: TextStyle(color: Colors.white, fontSize: 18.0),
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
              if (widget.selection == 'bloodGroup') {
                bloodGroupSelection = newValue;
              }
              else if(widget.selection == 'gender') {
                genderSelection = newValue;
              }
            });
          },
        ));
  }
}
