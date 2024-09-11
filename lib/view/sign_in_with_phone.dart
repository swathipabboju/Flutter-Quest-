import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PhoneSignInScreen extends StatefulWidget {
  @override
  _PhoneSignInScreenState createState() => _PhoneSignInScreenState();
}

class _PhoneSignInScreenState extends State<PhoneSignInScreen> {
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _smsController = TextEditingController();
  String? _verificationId;

  Future<void> _verifyPhoneNumber() async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: _phoneController.text,
      verificationCompleted: (PhoneAuthCredential credential) async {
        await FirebaseAuth.instance.signInWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e);
      },
      codeSent: (String verificationId, int? resendToken) {
        _verificationId = verificationId;
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        _verificationId = verificationId;
      },
    );
  }

  Future<void> _signInWithSmsCode() async {
    final credential = PhoneAuthProvider.credential(
      verificationId: _verificationId!,
      smsCode: _smsController.text,
    );
    await FirebaseAuth.instance.signInWithCredential(credential);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Phone Sign In'),
      ),
      body: Column(
        children: [
          TextField(
            controller: _phoneController,
            decoration: InputDecoration(labelText: 'Phone Number'),
          ),
          ElevatedButton(
            onPressed: _verifyPhoneNumber,
            child: Text('Verify'),
          ),
          TextField(
            controller: _smsController,
            decoration: InputDecoration(labelText: 'SMS Code'),
          ),
          ElevatedButton(
            onPressed: _signInWithSmsCode,
            child: Text('Sign In'),
          ),
        ],
      ),
    );
  }
}
