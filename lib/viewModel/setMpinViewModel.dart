import 'package:flutter/material.dart';
import 'package:sample_app/utils/Routes/appRoutes.dart';

class SetMpinViewModel with ChangeNotifier {
  MpinsCheck(String mpin, String Confirm_mpin, BuildContext context) {
    //Code for checking mpins match or not
    Navigator.pushNamed(context, AppRoutes.ValidateMpin);
  }
}
