import 'package:flutter/material.dart';

import '../utils/CustomAlerts/customAlert_1.dart';

class LoginViewModel with ChangeNotifier {
  Login(String mobile, BuildContext context) async {
    if (validateInputs(mobile, context)) {
      //code for verfication of mobile
    }
  }

  validateInputs(mobile, context) {
    if (mobile.isEmpty) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertWithSingleButton(
              title: "Mobile Number Empty",
              descriptions:
                  "Mobile Number cannot be empty,Please Enter Mobile Number",
              Buttontext: "OK",
              bgColor: Colors.red[900],
              Img: Image.asset(
                "assets/closeBgicon.png",
                fit: BoxFit.fill,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            );
          });
      return false;
    } else if (mobile.length < 10) {
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertWithSingleButton(
              title: "MOBILE NUMBER INVALID",
              descriptions: "Please Enter Valid Mobile Number",
              Buttontext: "OK",
              Img: Image.asset("assets/warningblue.png"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            );
          });
      return false;
    } else {
      return true;
    }
  }
}
