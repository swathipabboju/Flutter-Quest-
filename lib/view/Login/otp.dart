import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample_app/viewModel/otpViewModel.dart';
import '../../utils/ReusableWidgets/pincodefield.dart';

class Otp extends StatefulWidget {
  final String? phnNumber;
  final String? code;
  final String? from;
  Otp({Key? key, this.phnNumber, this.from, this.code}) : super(key: key);

  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> {
  double? height;
  double? width;
  String? otp_final;
  TextEditingController? contrller1;
  TextEditingController? contrller2;
  TextEditingController? contrller3;
  TextEditingController? contrller4;
  TextEditingController? contrller5;
  TextEditingController? contrller6;
  @override
  void initState() {
    super.initState();
    contrller1 = TextEditingController();
    contrller2 = TextEditingController();
    contrller3 = TextEditingController();
    contrller4 = TextEditingController();
    contrller5 = TextEditingController();
    contrller6 = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    final otpProvider = Provider.of<OtpViewModel>(context);
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(
          "Verification",
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24, horizontal: 8),
          child: Column(
            children: [
              Text(
                "We have send verification code on your mobile number",
              ),
              SizedBox(
                height: height! / 38,
              ),
              Column(
                children: [
                  PinCodeFields(
                    length: 6,
                    fieldBorderStyle: FieldBorderStyle.square,
                    controller: contrller1,
                    responsive: false,
                    fieldHeight: 35.0,
                    fieldWidth: 35.0,
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
                    onComplete: (Otp) {
                      // Your logic with pin code
                      print(Otp);
                      otp_final = Otp;
                      print(otp_final);
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        otpProvider.ResendOtp();
                      },
                      child: Text(
                        "Resend OTP?",
                      ),
                    ),
                  ),
                  SizedBox(
                    height: height! / 28,
                  ),
                  GestureDetector(
                    onTap: () {
                      otpProvider.CheckOtp(otp_final!, context);
                    },
                    child: Container(
                        height: height! / 18,
                        width: width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            "Verify",
                            style: TextStyle(color: Colors.black, fontSize: 20),
                          ),
                        )),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
