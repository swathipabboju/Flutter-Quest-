import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/utils/AppAssetsPath/assetpath.dart';
import 'package:sample_app/viewModel/resetPasswordViewModel.dart';
import '../../utils/ReusableWidgets/button.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class ForgotPasswordPage extends StatelessWidget {
  ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ResetPasswordProvider = Provider.of<ResetPasswordModel>(context);
    String phoneNumber = "";
/*     FocusScopeNode _node = FocusScopeNode();
    TextEditingController _mobile = TextEditingController(); */
    return Scaffold(
      appBar: AppBar(
        title: Text("RESET PASSWORD"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          CircleAvatar(
            radius: 52,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AppAssets.AppIcon),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: IntlPhoneField(
                    decoration: InputDecoration(
                      //decoration for Input Field
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode:
                        'IN', //default contry code, IN for India
                    onChanged: (phone) {
                      //when phone number country code is changed
                      print(phone.completeNumber); //get complete number
                      print(phone.countryCode); // get country code only
                      print(phone.number);
                      phoneNumber = phone.completeNumber; // only phone number
                    },
                  ),
                ),
              ),
              ReusableButton(
                ButtonText: "Continue",
                onPressed: () {
                  ResetPasswordProvider.ResetPassword(phoneNumber, context);
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
