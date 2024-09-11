import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/utils/ReusableWidgets/button.dart';
import 'package:sample_app/utils/ReusableWidgets/pincodefield.dart';
import 'package:sample_app/viewModel/validateMpinViewModel.dart';

import '../../utils/AppAssetsPath/assetpath.dart';

class ValidateMpin extends StatefulWidget {
  ValidateMpin({super.key});

  @override
  State<ValidateMpin> createState() => _ValidateMpinState();
}

class _ValidateMpinState extends State<ValidateMpin> {
  double? height;

  double? width;

  String? Mpin;

  TextEditingController? contrller1;

  TextEditingController? contrller2;

  TextEditingController? contrller3;

  TextEditingController? contrller4;

  @override
  Widget build(BuildContext context) {
    final validateMpinProvider = Provider.of<ValidateMpinViewModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 52,
            backgroundColor: Colors.transparent,
            backgroundImage: AssetImage(AppAssets.AppIcon),
          ),
          Text(
            "VALIDATE MPIN",
            style: TextStyle(fontSize: 24),
          ),
          PinCodeFields(
            length: 4,
            fieldBorderStyle: FieldBorderStyle.square,
            controller: contrller1,
            responsive: false,
            fieldHeight: 40.0,
            fieldWidth: 40.0,
            borderWidth: 2.0,
            obscureCharacter: "˙",
            obscureText: true,
            activeBorderColor: Colors.black,
            borderRadius: BorderRadius.circular(10.0),
            keyboardType: TextInputType.number,
            autoHideKeyboard: true,
            borderColor: Colors.black,
            textStyle: TextStyle(
              color: Colors.black,
              fontSize: 80.0,
              fontWeight: FontWeight.bold,
            ),
            onComplete: (mpin) {
              // Your logic with pin code
              Mpin = mpin;
            },
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Not You?",
                      style: TextStyle(decoration: TextDecoration.underline),
                    )),
                TextButton(
                    onPressed: () {},
                    child: Text(
                      "Forgot Mpin",
                      style: TextStyle(decoration: TextDecoration.underline),
                    ))
              ],
            ),
          ),
          ReusableButton(
            ButtonText: "Validate",
            onPressed: () {
              validateMpinProvider.ValidateMpin(Mpin!, context);
            },
          )
        ],
      ),
    );
  }
}
