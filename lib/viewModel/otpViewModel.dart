import 'package:flutter/material.dart';
import 'package:sample_app/utils/Routes/appRoutes.dart';

class OtpViewModel with ChangeNotifier {
  CheckOtp(String otp, BuildContext context) async {
    //code for verfication of otp
    Navigator.pushNamed(context, AppRoutes.SetMpinScreen);
  }
  ResendOtp(){
    //code for resending otp
  }
}
