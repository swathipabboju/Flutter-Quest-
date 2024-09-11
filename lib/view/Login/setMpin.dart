import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/utils/ReusableWidgets/button.dart';
import 'package:sample_app/utils/ReusableWidgets/pincodefield.dart';
import 'package:sample_app/viewModel/setMpinViewModel.dart';
import '../../utils/AppAssetsPath/assetpath.dart';

class SetMPINPage extends StatefulWidget {
  SetMPINPage({super.key});

  @override
  State<SetMPINPage> createState() => _SetMPINPageState();
}

class _SetMPINPageState extends State<SetMPINPage> {
  double? height;
  double? width;
  String? mpin;
  String? Confirm_mpin;
  TextEditingController? contrller1;
  TextEditingController? contrller2;
  TextEditingController? contrller3;
  TextEditingController? contrller4;
  TextEditingController? contrller5;
  TextEditingController? contrller6;
  TextEditingController? contrller7;
  TextEditingController? contrller8;
  @override
  Widget build(BuildContext context) {
    final MpinProvider = Provider.of<SetMpinViewModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 52,
              backgroundColor: Colors.transparent,
              backgroundImage: AssetImage(AppAssets.AppIcon),
            ),
            Text(
              "SET MPIN",
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
              activeBorderColor: Colors.black,
              borderRadius: BorderRadius.circular(10.0),
              keyboardType: TextInputType.number,
              autoHideKeyboard: true,
              borderColor: Colors.black,
              textStyle: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
              onComplete: (mpin) {
                // Your logic with pin code
                this.mpin = mpin;
                print("Mpin: $mpin");
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "CONFIRM MPIN",
                style: TextStyle(fontSize: 20),
              ),
            ),
            PinCodeFields(
                length: 4,
                fieldBorderStyle: FieldBorderStyle.square,
                controller: contrller1,
                responsive: false,
                fieldHeight: 40.0,
                fieldWidth: 40.0,
                borderWidth: 2.0,
                activeBorderColor: Colors.black,
                borderRadius: BorderRadius.circular(10.0),
                keyboardType: TextInputType.number,
                autoHideKeyboard: true,
                borderColor: Colors.black,
                textStyle: TextStyle(
                  color: Colors.black,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
                onComplete: (Confirm_mpin) {
                  this.Confirm_mpin = Confirm_mpin;
                  print("Confirm :$Confirm_mpin");
                }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ReusableButton(
                onPressed: () {
                  MpinProvider.MpinsCheck(mpin!, Confirm_mpin!, context);
                },
                ButtonText: 'Submit',
              ),
            )
          ],
        ),
      ),
    );
  }
}
