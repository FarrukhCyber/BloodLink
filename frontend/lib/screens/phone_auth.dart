import 'dart:convert';

import 'package:bloodlink/screens/login.dart';
import 'package:bloodlink/screens/myRequests.dart';
import 'package:bloodlink/screens/networkHandler.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bloodlink/screens/otp.dart';

class LoginWithPhone extends StatefulWidget {
  bool forget;
  bool edit;
  LoginWithPhone({Key? key, required this.forget, required this.edit}) : super(key: key);

  @override
  _LoginWithPhoneState createState() => _LoginWithPhoneState();
}

class _LoginWithPhoneState extends State<LoginWithPhone> {
  bool correctformat = false;
  TextEditingController phoneController = TextEditingController();
  NetworkHandler networkHandler = NetworkHandler();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool otpVisibility = false;
  var phone = "";

  String verificationID = "";

  errorGenerator(context, title, message, flag) {
    showDialog(
        context: context,
        builder: (BuildContext context) => AlertDialog(
              title: Text(title),
              content: Text(message),
              actions: <Widget>[
                TextButton(
                  onPressed: () => {
                    if (flag)
                      {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => login(),
                        ))
                      }
                    else
                      {
                        Navigator.pop(context, 'Ok'),
                      }
                  },
                  child: const Text('Ok'),
                ),
              ],
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24, horizontal: 32),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Icon(
                      Icons.arrow_back,
                      size: 32,
                      color: Colors.black54,
                    ),
                  ),
                ),
                SizedBox(
                  height: 18,
                ),
                Container(
                  width: 200,
                  height: 200,
                  decoration: BoxDecoration(
                    color: Colors.deepPurple.shade50,
                    shape: BoxShape.circle,
                  ),
                  child: Image.asset(
                    'assets/illustration.png',
                  ),
                ),
                SizedBox(
                  height: 24,
                ),
                Text(
                  'Registration',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Add your phone number. we'll send you a verification code so we know you're real",
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black38,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 28,
                ),
                Container(
                  padding: EdgeInsets.all(28),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    children: [
                      TextFormField(
                          validator: (value) =>
                              isValidPhoneNumber(value ?? "") == false
                                  ? "Please enter a number of lenght 10"
                                  : null,
                          textInputAction: TextInputAction.next,
                          autofocus: false,
                          controller: phoneController, //check this
                          onSaved: (value) {
                            value != null ? phone = value : null;
                          },
                          onChanged: (value) {
                            phone = value;
                          },
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              labelText: "Phone Number",
                              errorMaxLines: 4,
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.always,
                              filled: true,
                              contentPadding:
                                  EdgeInsets.fromLTRB(20, 15, 20, 15),
                              hintText: "3xxxxxxxxx",
                              border: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffde2c2c).withOpacity(0.3),
                                    width: 2.0),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffde2c2c), width: 2.0),
                              ),
                              errorBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffde2c2c), width: 2.0),
                              ),
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                    color: Color(0xffde2c2c).withOpacity(0.3),
                                    width: 2.0),
                              ),
                              prefix: const Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Text(
                                  '(+92)',
                                ),
                              ),
                              suffixIcon: Visibility(
                                visible: phoneController.text.length == 10,
                                child: const Icon(
                                  Icons.check_circle,
                                  color: Colors.green,
                                  size: 32,
                                ),
                              ))),
                      SizedBox(
                        height: 22,
                      ),
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (otpVisibility) {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => Otp(
                                          authen: auth,
                                          verify: verificationID,
                                          phoneNo: "+92" + phone,
                                          forget: widget.forget,
                                          edit:widget.edit
                                        )),
                              );
                              //verifyOTP();
                            } else {
                              if (!isValidPhoneNumber(phoneController.text)) {
                                errorGenerator(
                                    context,
                                    "Invalid Phone Number",
                                    "Please Enter correct 10 digit number 3xxxxxxxxxx",
                                    false);
                                phoneController.clear();
                              } else {
                                if (widget.forget == false || widget.edit==true) {
                                  var msg = await networkHandler.get(
                                      '/auth/phone',
                                      "92" + phoneController.text,
                                      "user_contact_num");
                                  var mess = (json.decode(msg.body));
                                  print("line 215");
                                  print(mess);
                                  var message = mess["msg"];
                                  if (message == "ERROR") {
                                    errorGenerator(
                                        context,
                                        "There was an error in server",
                                        "Please try again in some time",
                                        !widget.edit);
                                    phoneController.clear();
                                  } else if (message == "exists") {
                                    errorGenerator(
                                        context,
                                        "Number already registered",
                                        "Please use some other Phone Number or LogIn",
                                        !widget.edit);
                                    phoneController.clear();
                                  } else if (message == "null") {
                                    print("line 233");
                                    loginWithPhone();
                                  }
                                } else {
                                  print(phoneController.text);
                                  var msg = await networkHandler.get(
                                      '/auth/phone',
                                      "92" + phoneController.text,
                                      "user_contact_num");
                                  var mess = (json.decode(msg.body));
                                  print(mess);
                                  var message = mess["msg"];
                                  if (message == "ERROR") {
                                    errorGenerator(
                                        context,
                                        "There was an error in server",
                                        "Please try again in some time",
                                        false);
                                    phoneController.clear();
                                  } else if (message == "exists") {
                                    loginWithPhone();
                                  } else if (message == "null") {
                                    await errorGenerator(
                                        context,
                                        "Number not registered",
                                        "Please Create a New Account",
                                        false);
                                    //Navigator.of(context)
                                    //    .push(MaterialPageRoute(
                                    //  builder: (context) => login(),
                                    //));
                                    phoneController.clear();
                                  }
                                }
                              }
                            }
                          },
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                            backgroundColor: MaterialStateProperty.all<Color>(
                                Color.fromARGB(255, 193, 0, 0)),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(24.0),
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(14.0),
                            child: Text(
                              'Send',
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void loginWithPhone() async {
    auth.verifyPhoneNumber(
      phoneNumber: "+92" + phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await auth.signInWithCredential(credential).then((value) {
          print("You are logged in successfully");
        });
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.message);
      },
      codeSent: (String verificationId, int? resendToken) {
        otpVisibility = true;
        verificationID = verificationId;
        setState(() {});
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}

bool isValidPhoneNumber(String string) {
  // Null or empty string is invalid phone number
  if (string == null || string.isEmpty) {
    return false;
  }

  if (string.length != 10) {
    return false;
  }
  return true;
}
